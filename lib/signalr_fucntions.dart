import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'main.dart';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:provider/provider.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/dependency_injection.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'screens/home/home_state.dart';
import 'screens/chat/chat_state.dart';
import 'screens/create_group/create_group_state.dart';
import 'screens/new_chat/new_chat_state.dart';
import 'screens/new_contact/new_contact_state.dart';
import 'screens/sign_up/sign_up_state.dart';
import 'core/navigation/router.dart';
import 'core/dependency_injection.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'core/classes/chat.dart';
import 'core/classes/message.dart';



void define_signalr_functions(){

  final myHomeState = getIt<HomeState>();
  final myChatState = getIt<ChatState>();

  connection.on('ReceiveNewMessage', (message) async{
    debugPrint("new message received");
    int targetIndex = myHomeState.chats.indexWhere((e) => e.chatName == message![0].toString());
    if(targetIndex != -1){
      myHomeState.chats[targetIndex].messages.add( Message(sender: message![0], text: message[1], senderUserName: message[2]));
      myHomeState.chats.insert(0, myHomeState.chats[targetIndex]);
      myHomeState.chats.removeAt(targetIndex + 1);
      myChatState.rebuildChatList.toggle();
      myHomeState.rebuildChatList.toggle();
    }else{
      debugPrint("send request to get image");
      Map<String, String> requestHeaders = {
        "Connection": "keep-alive",
      };
      http.Response response = await http.post(
          Uri.parse("http://10.0.2.2:9000/api/Image/${message![0]}",),
          headers: requestHeaders

      );
      debugPrint("image received");
      final base64Image = base64.encode(response.bodyBytes);
      myHomeState.chats.insert(0, Chat(type: ChatType.contact, chatName: message[0].toString(), messages:
      [Message(sender: message[0], text: message[1], senderUserName: message[2],)],userName: message[2],
      image: base64Image),);
      myHomeState.rebuildChatList.toggle();
    }

    debugPrint("new message received from ${message[0]}");
    debugPrint(message[1]);
  });
  connection.on('receiveUserName', (message){
    debugPrint("user name is : ${message![1]}");
    int targetChat = myHomeState.chats.indexWhere((element) => element.chatName == message[0].toString());
    myHomeState.chats[targetChat].userName = message[1];
    debugPrint("receive user name");
    myHomeState.userNameReceived.toggle();
    myHomeState.rebuildChatList.toggle();
  });

  connection.on('GroupMessage', (message) {
    debugPrint("new message for group ${message![0]} form user ${message[1]} received, message is ${message[2]}");
    debugPrint(message[1].toString());
    int targetIndex = myHomeState.chats.indexWhere((e) => e.chatName == message[0]);
    if(targetIndex != -1){
      myHomeState.chats[targetIndex].messages.add(Message(sender: message[1], text: message[2], senderUserName: message[3]));
      myHomeState.chats.insert(0, myHomeState.chats[targetIndex]);
      myHomeState.chats.removeAt(targetIndex + 1);
      myChatState.rebuildChatList.toggle();
      myHomeState.rebuildChatList.toggle();
    }else{
      debugPrint("here1");
      myHomeState.chats.insert(0, Chat(type: ChatType.contact, chatName: message[0].toString(), messages:
      [Message(sender: message[1], text: message[2], senderUserName: message[3]),]));
      myHomeState.rebuildChatList.toggle();
    }

  });

  connection.on('ReceiveId', (message) {
    myHomeState.myId = message![0];
    debugPrint("client id is ${myHomeState.myId}");
    connection.invoke('ReceiveFireBaseToken', args: [myHomeState.firebaseToken]);
    debugPrint("connection status:  ${connection.state}");
    debugPrint("sending token");
    myHomeState.idReceived.toggle();
  });

}