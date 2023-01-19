import 'dart:convert';
import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'package:signalr_core/signalr_core.dart';
import 'package:flutter/material.dart';
import 'package:signalr_core/signalr_core.dart';

import '/core/constants/route_names.dart';
import '/core/constants/ui.dart';
import '/core/dependency_injection.dart';
import '/core/interfaces/controller.dart';
import '../../main.dart';
import '/core/util/failure_handler.dart';
import 'home_repository.dart';
import 'home_state.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:http/io_client.dart';
import '../../core/classes/chat.dart';
import '../../core/classes/message.dart';







class HomeController extends MainController {
  final HomeState homeState = getIt<HomeState>();
  final HubConnection connection = getIt<HubConnection>();
  // final HomeRepository homeRepository = getIt<HomeRepository>();
  int selectedChat = -1;
  String selectedGroup = "none";
  //todo move this variable to chat state
  TextEditingController message = TextEditingController();
  TextEditingController id = TextEditingController();
  //todo move controllers to state



  @override
  void onInit({dynamic args}) {


  }

  void sendMessageToContact(){
    connection.invoke('sendMessage', args: [int.parse(id.text), message.text]);
    //todo do not pass any argument move them to screen state
  }

  void goToChatScreen(String chatKey){
    
    myNavigator.goToName(RouteNames.chat, extra: chatKey);
  }
  void goToNewChatScreen(){
    myNavigator.goToName(RouteNames.newChat);
  }





}
