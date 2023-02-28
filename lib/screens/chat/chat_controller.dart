import 'dart:core';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:messaging_signalr/messaging_signalr.dart';

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

  Map<String,String> lastMessage = <String,String>{};

  int indexBeforeAdd = 0;

  @override
  void onInit() {

    chatState.textMessageController.clear();
    if(lastMessage.containsKey(chatState.chatKey.value)){
      chatState.textMessageController.text = lastMessage[chatState.chatKey.value]!;
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

    chatState.setChat = signalRMessaging.chats.firstWhere((element) {
      return element.chatId == chatState.chatKey.value;
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
      int lastIndex = chatState.selectedChat.messages.length - 1;
      // indexBeforeAdd != lastIndex && itemPositionsList.isNotEmpty && lastIndex != itemPositionsList.last.index
      //indexBeforeAdd != lastIndex &&  (lastIndex != itemPositionsList.last.index || itemPositionsList.last.itemTrailingEdge > 1)
      debugPrint(
          "${indexBeforeAdd != lastIndex}, ${lastIndex != itemPositionsList.last.index},  ${itemPositionsList.last.itemTrailingEdge > 1}");
      if (indexBeforeAdd != lastIndex &&
          (lastIndex != itemPositionsList.last.index || itemPositionsList.last.itemTrailingEdge > 1)) {
        int lastIndex = chatState.selectedChat.messages.length - 1;
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
    chatState.setState();
  }

  void bachToHomeScreen() {
    myNavigator.goToName(RouteNames.home);
  }

  void textControllerChanged(String str) {

    //store last message
    lastMessage[chatState.chatKey.value] = str;


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
