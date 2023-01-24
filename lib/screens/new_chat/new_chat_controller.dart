import 'dart:convert';
import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// import '/core/classes/flight_element_class.dart';
// import '/core/classes/login_class.dart';
// import '/core/constants/assets.dart';
import '/core/constants/route_names.dart';
// import '/core/constants/share_preferences_keys.dart';
import '/core/constants/ui.dart';
import '/core/dependency_injection.dart';
import '/core/interfaces/controller.dart';
import '../../main.dart';
import '/core/util/failure_handler.dart';
import 'new_chat_state.dart';
import '../home/home_state.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:http/io_client.dart';
import '../../core/classes/chat.dart';
import '../../core/classes/message.dart';



// List<MapEntry<String, List<Map<int,String>>>> chats = [];



class NewChatController extends MainController {
  final NewChatState chatState = getIt<NewChatState>();
  // final HomeRepository homeRepository = getIt<HomeRepository>();




  @override
  void onInit({dynamic args}) {

  }
  //
  // void sendMessageToContact(){
  //   // connection.invoke('sendMessage', args: [int.parse(id.text), message.text]);
  // }
  void backToHomeScreen(){
    myNavigator.goToName(RouteNames.home);
  }
  void goToNewContactScreen(){
    myNavigator.goToName(RouteNames.newContact);
  }
  void goToCreateGroupScreen(){
    myNavigator.goToName(RouteNames.createGroup);
  }





}
