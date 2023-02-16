import 'dart:core';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
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
  // final HubConnection connection = getIt<HubConnection>();

  int indexBeforeAdd = 0;

  @override
  void onInit() {
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
      debugPrint("${indexBeforeAdd != lastIndex}, ${lastIndex != itemPositionsList.last.index},  ${itemPositionsList.last.itemTrailingEdge > 1}");
      if (indexBeforeAdd != lastIndex &&
          (lastIndex != itemPositionsList.last.index || itemPositionsList.last.itemTrailingEdge > 1)) {
        int lastIndex = chatState.selectedChat.messages.length - 1;
          debugPrint("scroll jumped");
          debugPrint("${itemPositionsList.last.index}");
          debugPrint("$lastIndex");
          chatState.itemScrollController.scrollTo(index: lastIndex, duration: const Duration(milliseconds: 400), curve: Curves.easeInOutCubic,);
        indexBeforeAdd = lastIndex;
      }
    });

    super.onInit();
  }

  void sendMessage(bool privateChat) {
    signalRMessaging.sendMessage(
        privateChat: privateChat, message: chatState.textController.text, chatId: chatState.chatKey.value);
    chatState.textController.clear();
    chatState.setState();
  }

  void bachToHomeScreen() {
    myNavigator.goToName(RouteNames.home);
  }

  void textControllerChanged(String str) {
    if (str == "") {
      chatState.setShowSendMessageIcon = false;
    } else if (str != "") {
      chatState.setShowSendMessageIcon = true;
    }
  }
}
