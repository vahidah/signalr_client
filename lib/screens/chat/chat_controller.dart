import 'dart:core';
import 'package:dartz/dartz.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:messaging_signalr/messaging_signalr.dart';
import 'package:signalr_client/core/util/Extensions.dart';

import '/core/constants/route_names.dart';
import '/core/dependency_injection.dart';
import '/core/interfaces/controller.dart';
import 'chat_state.dart';
import '../home/home_state.dart';

final ourKey = GlobalKey();

class ChatController extends MainController {
  final ChatState chatState = getIt<ChatState>();
  final HomeState homeState = getIt<HomeState>();
  final SignalRMessaging signalRMessaging = getIt<SignalRMessaging>();

  //we store it to know the last item added is emoji or character

  Map<String, String> draftMessage = <String, String>{};

  bool newMessageAdded = false;
  bool fistTimePageOpened = true;

  bool firstTimeOpenKeyboard = false;

  int itemNumber = 0;

  int datesShown = 0;

  List<DateTime> days = [];

  Map<int, String> listViewElements = <int, String>{};

  DateFormat format = DateFormat("MMMM dd");

  void computeItemNumber() {
    debugPrint("here in computeItemNumber");

    List<DateTime> days = [];

    if (chatState.selectedChat != null && chatState.selectedChat!.messages.isNotEmpty) {
      debugPrint("here in computeItemNumber1");
      int i = 0;
      int j = 0;
      for (var element in chatState.selectedChat!.messages) {
        debugPrint("here in computeItemNumber5");
        bool haveThisDay = false;
        for (var day in days) {
          if (day.isSameDate(element.date!)) {
            haveThisDay = true;
          }
        }
        if (!haveThisDay) {
          days.add(element.date!);
          debugPrint("here in computeItemNumber2");
          listViewElements.addEntries([MapEntry<int, String>(i + j, "date")]);
          j++;
        }
        listViewElements.addEntries([MapEntry<int, String>(i + j, "Message|$i")]);
        debugPrint("here in computeItemNumber3");

        i++;
      }
      debugPrint("itemNumber is ${days.length + chatState.selectedChat!.messages.length}");
      itemNumber = days.length + chatState.selectedChat!.messages.length;
      debugPrint("here in computeItemNumber4");
      debugPrint("itemNumberValue: $itemNumber");
      listViewElements.forEach((key, value) {
        debugPrint("map element key is: ${key} value is ${value}");
      });
    }
  }

  @override
  void onInit() {
    days.clear();

    chatState.setChat = signalRMessaging.chats.firstWhere((element) {
      return element.chatId == chatState.chatKey.value;
    });

    if (chatState.selectedChat!.messages.isEmpty) {
      itemNumber = 0;
    } else {
      itemNumber = 1 + days.length + chatState.selectedChat!.messages.length;
    }

    chatState.textMessageController.clear();
    chatState.emojiController.clear();

    if (draftMessage.containsKey(chatState.chatKey.value)) {
      chatState.textMessageController.text = draftMessage[chatState.chatKey.value]!;
    }

    // chatState.textMessageController.ad

    chatState.textMessageController.addListener(() {});

    final scrollListener = chatState.itemPositionsListener;

    scrollListener.itemPositions.addListener(() {
      //todo use it just for check seen of message
      // final itemPositionsList = scrollListener.itemPositions.value.toList();
      //
      // int lastIndex = chatState.selectedChat!.messages.length - 1;
      //
      // if (indexBeforeAdd != lastIndex &&
      //     (lastIndex != itemPositionsList.last.index || itemPositionsList.last.itemTrailingEdge > 1)) {
      //   int lastIndex = chatState.selectedChat!.messages.length - 1;
      //   chatState.itemScrollController.scrollTo(
      //     index: lastIndex,
      //     duration: const Duration(milliseconds: 400),
      //     curve: Curves.easeInOutCubic,
      //   );
      //   indexBeforeAdd = lastIndex;
      // }
      final itemPositionsList = scrollListener.itemPositions.value.toList();

      if ((newMessageAdded && itemPositionsList.last.itemTrailingEdge > 1) || fistTimePageOpened) {
        fistTimePageOpened = false;
        newMessageAdded = false;
        chatState.itemScrollController.scrollTo(
          index: itemPositionsList.last.index,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOutCubic,
        );
      }
    });

    super.onInit();
  }

  void sendMessage(bool privateChat) {
    newMessageAdded = true;
    signalRMessaging.sendMessage(
        privateChat: privateChat, message: chatState.textMessageController.text, chatId: chatState.chatKey.value);
    chatState.textMessageController.clear();
    draftMessage.remove(chatState.selectedChat!.chatId);
  }

  void bachToHomeScreen() {
    nav.goToName(RouteNames.home);
    fistTimePageOpened = true;
  }

  void textControllerChanged(String str) {
    //store last message
    draftMessage[chatState.chatKey.value] = str;

    //change icon
    if (str == "") {
      chatState.setShowSendMessageIcon = false;
    } else if (str != "") {
      chatState.setShowSendMessageIcon = true;
    }
  }

  Future toggleEmojiKeyboard() async {
    // await SystemChannels.textInput.invokeMethod("TextInput.hide");
    // await Future.delayed(const Duration(milliseconds: 100));
    debugPrint("in toggleEmojiKeyboard");

    chatState.setEmojiPickerVisible = !chatState.emojiPickerInvisible;
    //
    if (!firstTimeOpenKeyboard) {
      chatState.showEmojiIcon.value = !chatState.showEmojiIcon.value;
      firstTimeOpenKeyboard = false;
    }

    if (!chatState.emojiPickerInvisible) {
      chatState.textInputFocus.unfocus();
      chatState.setState();
    } else {
      chatState.setState();
      chatState.textInputFocus.requestFocus();
    }
  }

  void onEmojiSelected(Category? category, Emoji emoji) {
    var cursorPos = chatState.textMessageController.selection.base.offset;

    String firstPart = chatState.textMessageController.text.substring(0, cursorPos);
    String secondPart =
        chatState.textMessageController.text.substring(cursorPos, chatState.textMessageController.text.length);

    String newText = firstPart + emoji.emoji + secondPart;
    int lengthDiff = newText.length - chatState.textMessageController.text.length;
    chatState.textMessageController.text = newText;

    chatState.textMessageController.selection = TextSelection.collapsed(offset: cursorPos + lengthDiff);

    chatState.setState();
  }

  void tapOnTextField() {
    debugPrint("focus check ${chatState.textInputFocus.hasFocus}");
    if (!chatState.emojiPickerInvisible) {
      chatState.setEmojiPickerVisible = true;
    }
  }

  Future<bool> onWillPop() async {
    if (!chatState.emojiPickerInvisible) {
      chatState.setEmojiPickerVisible = true;
      firstTimeOpenKeyboard = true;
    } else {
      nav.goToName(RouteNames.home);
      fistTimePageOpened = true;
    }
    return false;
  }
}
