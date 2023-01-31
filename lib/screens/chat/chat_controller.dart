import 'dart:core';
import 'package:signalr_client/core/constants/constant_values.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



import '/core/constants/route_names.dart';
import '/core/dependency_injection.dart';
import '/core/interfaces/controller.dart';
import 'chat_state.dart';
import '../home/home_state.dart';
import '../../core/classes/message.dart';





class ChatController extends MainController {
  final ChatState chatState = getIt<ChatState>();
  final HomeState homeState = getIt<HomeState>();
  final HubConnection connection = getIt<HubConnection>();






  @override
  void onInit() {

    debugPrint("finding chatKey");
    chatState.chat = homeState.chats.firstWhere((element) {
      debugPrint("chatkey is : ${chatState.chatKey} and element key is : ${element.chatName}");
      return element.chatName == chatState.chatKey!.value;
    }).obs;
    super.onInit();
  }

  void sendMessage(bool privateChat){
    if(privateChat) {
      chatState.chat!.value.messages.add(
          Message(sender: ConstValues.myId, text: chatState.textController.text, senderUserName: ConstValues.userName));
      connection.invoke(
          'sendMessage', args: [int.parse(chatState.chat!.value.chatName), chatState.textController.text, false]);
    }else {
      connection.invoke('SendMessageToGroup', args: [chatState.chat!.value.chatName, ConstValues.myId, chatState.textController.text]);
    }
    chatState.textController.clear();
    chatState.setState();
  }

  // void sendMessageToContact(){
  //
  //
  //   chatState.chat!.value!.messages.add(Message(sender: homeState.myId, text: chatState.textController.text, senderUserName: homeState.userName!));
  //   connection.invoke('sendMessage', args: [int.parse(chatState.chat!.value!.chatName), chatState.textController.text, false]);
  //   chatState.textController.clear();
  //   chatState.setState();
  // }
  // void sendMessageToGroup(){
  //   //chatState.chat!.value!.messages.add(Message(sender: homeState.myId, text: chatState.textController.text, senderUserName: homeState.userName!));
  //
  //   chatState.textController.clear();
  //   chatState.setState();
  // }
  void bachToHomeScreen(){
    myNavigator.goToName(RouteNames.home);
  }

  void textControllerChanged(String str){

    if (str == "" && chatState.showSendMessageIcon) {
      chatState.setShowSendMessageIcon = false;
    } else if (str != "" && !chatState.showSendMessageIcon) {
      chatState.setShowSendMessageIcon = true;
    }
  }





}
