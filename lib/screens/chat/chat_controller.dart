import 'dart:core';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:messaging_signalr/messaging_signalr.dart';
import 'package:signalr_client/core/util/Extensions.dart';

import '/core/constants/route_names.dart';
import '/core/dependency_injection.dart';
import '/core/interfaces/controller.dart';
import 'chat_state.dart';
import '../home/home_state.dart';

class ChatController extends MainController {
  final ChatState chatState = getIt<ChatState>();
  final HomeState homeState = getIt<HomeState>();
  final SignalRMessaging signalRMessaging = getIt<SignalRMessaging>();

  bool emojiAdded = false;

  Map<String,String> draftMessage = <String,String>{};

  int indexBeforeAdd = 0;

  int itemNumber = 0;
  int datesShown = 0;

  DateTime? a;

  List<DateTime> days = [];

  DateFormat format = DateFormat("MMMM dd");

  void computeItemNumber(){
    debugPrint("computeItemNumber called");
    if(chatState.selectedChat != null && chatState.selectedChat!.messages.isNotEmpty) {
      for (var element in chatState.selectedChat!.messages) {
        bool haveThisDay = false;
        for (var day in days) {
          if (day.isSameDate(element.date!)) {
            haveThisDay = true;
          }
        }
        if (!haveThisDay) {
          days.add(element.date!);
        }
      }
      itemNumber = days.length + chatState.selectedChat!.messages.length;
    }

    debugPrint("itemNumberValue: $itemNumber");
  }

  @override
  void onInit() {

    days.clear();


    chatState.setChat = signalRMessaging.chats.firstWhere((element) {
      return element.chatId == chatState.chatKey.value;
    });


    if(chatState.selectedChat!.messages.isEmpty){
      itemNumber = 0;
    }else{
      itemNumber = 1 + days.length + chatState.selectedChat!.messages.length;
    }

    chatState.textMessageController.clear();
    chatState.emojiController.clear();

    if(draftMessage.containsKey(chatState.chatKey.value)){
      chatState.textMessageController.text = draftMessage[chatState.chatKey.value]!;
    }

    chatState.textMessageController.addListener(() {
      if(!emojiAdded) {
        debugPrint("when does it called?");
        if (chatState.textInputFocus.hasFocus) {
          chatState.setEmojiPickerVisible = true;
        }
        emojiAdded = false;
      }
    });


    debugPrint("after set chat");
    final scrollListener = chatState.itemPositionsListener;

    scrollListener.itemPositions.addListener(() {
      //todo use it just for check seen of message
      final itemPositionsList = scrollListener.itemPositions.value.toList();

      debugPrint("print trailing edges");

      for (var element in itemPositionsList) {
        debugPrint(element.itemTrailingEdge.toString());
      }
      int lastIndex = chatState.selectedChat!.messages.length - 1;
      // indexBeforeAdd != lastIndex && itemPositionsList.isNotEmpty && lastIndex != itemPositionsList.last.index
      //indexBeforeAdd != lastIndex &&  (lastIndex != itemPositionsList.last.index || itemPositionsList.last.itemTrailingEdge > 1)

      if (indexBeforeAdd != lastIndex &&
          (lastIndex != itemPositionsList.last.index || itemPositionsList.last.itemTrailingEdge > 1)) {
        int lastIndex = chatState.selectedChat!.messages.length - 1;
        debugPrint("scroll jumped");
        debugPrint("${itemPositionsList.last.index}");
        debugPrint("$lastIndex");
        chatState.itemScrollController.scrollTo(
          index: lastIndex,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOutCubic,
        );
        indexBeforeAdd = lastIndex;
      }
    });

    super.onInit();
  }

  void sendMessage(bool privateChat) {
    signalRMessaging.sendMessage(
        privateChat: privateChat, message: chatState.textMessageController.text, chatId: chatState.chatKey.value);
    chatState.textMessageController.clear();
    draftMessage.remove(chatState.selectedChat!.chatId);
    chatState.setState();
  }

  void bachToHomeScreen() {
    nav.goToName(RouteNames.home);
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
    await Future.delayed(const Duration(milliseconds: 100));
    debugPrint("in toggleEmojiKeyboard");


    chatState.setEmojiPickerVisible = !chatState.emojiPickerVisible;

    if (!chatState.emojiPickerVisible) {
      debugPrint("unfocus");
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      // chatState.textInputFocus.unfocus();
    }
  }

  void onEmojiSelected(Category? category, Emoji emoji) {
    var cursorPos =
        chatState.textMessageController.selection.base.offset;
    String firstPart = chatState.textMessageController.text.substring(0, cursorPos);
    String secondPart = chatState.textMessageController.text.substring(cursorPos, chatState.textMessageController.text.length);
    var newText = firstPart + emoji.emoji + secondPart;
    emojiAdded = true;
    chatState.textMessageController.text = newText;
    chatState.textMessageController.selection =
        TextSelection.collapsed(offset: cursorPos + 2);


  }

  void tapOnTextField(){
    debugPrint("when does it called?");
    if(chatState.textInputFocus.hasFocus){
      chatState.setEmojiPickerVisible = true;}
  }
}
