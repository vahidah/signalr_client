import 'dart:convert';
import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'package:intl/intl.dart';


import '/core/constants/apis.dart';
import '/core/constants/route_names.dart';
import '/core/constants/ui.dart';
import '/core/dependency_injection.dart';
import '/core/interfaces/controller.dart';
import '../../main.dart';
import '../home/home_state.dart';
import 'new_contact_state.dart';
import '../home/home_state.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:http/io_client.dart';
import '../../core/classes/chat.dart';
import '../../core/classes/message.dart';



// List<MapEntry<String, List<Map<int,String>>>> chats = [];



class NewContactController extends MainController {
  final NewContactState chatState = getIt<NewContactState>();
  final HomeState homeState = getIt<HomeState>();


  TextEditingController contactId = TextEditingController();
  TextEditingController firstMessage = TextEditingController();


  @override
  void onInit({dynamic args}) {

  }
  //
  // void sendMessageToContact(){
  //   // connection.invoke('sendMessage', args: [int.parse(id.text), message.text]);
  // }
  void backToNewChatScreen(){
    myNavigator.goToName(RouteNames.newChat);
  }

  void sendFirstMessage() async{
      debugPrint("here send first message");
      String base64Image;

      debugPrint("contact id is : ${int.parse(contactId.text)}");
     // Dio dio = Dio(  );

      // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      //   client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      //   return client;
      // };
      Map<String, String> requestHeaders = {
        "Connection": "keep-alive",
      };
      http.Response response = await http.post(
          Uri.parse("${Apis.getImage}/${int.parse(contactId.text)}",),
        headers: requestHeaders

      );
     // final response = await dio.post("${apis}${int.parse(contactId.text)}");
     // response.data.
      base64Image = base64.encode(response.bodyBytes);
      debugPrint("status code is ${response.statusCode}");
     homeState.userNameReceived.toggle();
      debugPrint("value is: ${homeState.userNameReceived.toggle()}");
      homeState.chats.insert(0, Chat(type: ChatType.contact, chatName: contactId.text,
          messages: [Message(sender: homeState.myId, text: firstMessage.text, senderUserName: homeState.userName!)],
      image: base64Image));
      connection.invoke('sendMessage', args: [int.parse(contactId.text), firstMessage.text, true]);
      // firstMessage.clear();
      // contactId.clear();

      homeState.rebuildChatList.toggle();
      //todo remove this rebuild the rebuild in receiveUserName method is enough


  }





}
