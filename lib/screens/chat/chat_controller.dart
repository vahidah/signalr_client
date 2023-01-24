import 'dart:convert';
import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'package:signalr_core/signalr_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



import '/core/constants/route_names.dart';
import '/core/constants/ui.dart';
import '/core/dependency_injection.dart';
import '/core/interfaces/controller.dart';
import '../../main.dart';
import '/core/util/failure_handler.dart';
import 'chat_state.dart';
import '../home/home_state.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:http/io_client.dart';
import '../../core/classes/chat.dart';
import '../../core/classes/message.dart';





class ChatController extends MainController {
  final ChatState chatState = getIt<ChatState>();
  final HomeState homeState = getIt<HomeState>();
  final HubConnection connection = getIt<HubConnection>();

  String? chatKey;
  Chat? chat;

  bool isItFirstChar = false;






  @override
  void onInit({dynamic args}) {
    chatKey = args;
    debugPrint("finding chatKey");
    chat = homeState.chats.firstWhere((element) {
      debugPrint("chatkey is : ${chatKey} and element key is : ${element.chatName}");
      return element.chatName == chatKey;
    });
  }

  void sendMessageToContact(){
    chat?.messages.add(Message(sender: homeState.myId, text: chatState.textController.text, senderUserName: homeState.userName!));
    connection.invoke('sendMessage', args: [int.parse(chat!.chatName), chatState.textController.text, false]);
    chatState.textController.clear();
    chatState.showSendMessageIcon.toggle();
    chatState.rebuildChatList.toggle();
  }
  void sendMessageToGroup(){
    // chat?.messages.add(Message(sender: homeState.myId, text: textController.text));
    connection.invoke('SendMessageToGroup', args: [chat!.chatName, homeState.myId, chatState.textController.text]);
    chatState.textController.clear();
    chatState.showSendMessageIcon.toggle();
    chatState.rebuildChatList.toggle();
  }
  void bachToHomeScreen(){
    myNavigator.goToName(RouteNames.home);
  }





}
