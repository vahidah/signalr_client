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
// import '/core/util/moon_icons.dart';
// import '/core/util/utils.dart';
// import '/widgets/calendar_pop_up.dart';
// import '/widgets/snack_bar_widget.dart';
// import '/widgets/top_dialog_bar.dart';
// import '../usecases/flight_list_usecase.dart';
// import '../usecases/flight_status_list_usecase.dart';
import 'home_repository.dart';
import 'home_state.dart';
// import 'widgets/notif_pop_up.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:http/io_client.dart';
import '../../core/classes/chat.dart';
import '../../core/classes/message.dart';







class HomeController extends MainController {
  final HomeState homeState = getIt<HomeState>();
  // final HomeRepository homeRepository = getIt<HomeRepository>();
  int selectedChat = -1;
  String selectedGroup = "none";
  TextEditingController message = TextEditingController();
  TextEditingController id = TextEditingController();

  int imageId = 0;

  bool justOne = true;


  @override
  void onInit({dynamic args}) {
    //todo remove lines below
    if(justOne) {
      // justOne = false;
      // homeState.chats.add(Chat(chatName: "New Group", type: ChatType.group, messages: []));
      // homeState.chats[0].messages.add(Message(sender: 4, text: "hi", senderUserName: "unknown"));
      //todo there is no need remove them


      // homeState.rebuildChatList.toggle();
      debugPrint("controller onInit");
    }
  }

  void sendMessageToContact(){
    connection.invoke('sendMessage', args: [int.parse(id.text), message.text]);
  }

  void goToChatScreen(String chatKey){
    debugPrint("before navigate");
    myNavigator.goToName(RouteNames.chat, extra: chatKey);
    debugPrint("after navigate");
  }
  void goToNewChatScreen(){
    myNavigator.goToName(RouteNames.newChat);
  }





}
