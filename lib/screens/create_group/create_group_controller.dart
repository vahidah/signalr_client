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
import 'create_group_state.dart';
import '../home/home_state.dart';
// import 'widgets/notif_pop_up.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:http/io_client.dart';
import '../../core/classes/chat.dart';
import '../../core/classes/message.dart';



// List<MapEntry<String, List<Map<int,String>>>> chats = [];



class CreateGroupController extends MainController {
  final CreateGroupState chatState = getIt<CreateGroupState>();
  final HomeState homeState = getIt<HomeState>();
  // final HomeRepository homeRepository = getIt<HomeRepository>();


  TextEditingController groupName = TextEditingController();




  @override
  void onInit({dynamic args}) {

  }

  void createGroup(){
    if(!homeState.chats.any((element) => element.chatName == groupName.text)) {
      homeState.chats.add(Chat(type: ChatType.group, chatName: groupName.text,
          messages: []));
      connection.invoke('AddToGroup', args: [groupName.text]);
      homeState.rebuildChatList.toggle();
    }
  }
  void backToHomeScreen(){
    myNavigator.goToName(RouteNames.newChat);
  }





}
