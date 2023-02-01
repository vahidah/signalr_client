import 'dart:convert';
import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'package:messaging_signalr/messaging_signalr.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/core/constants/route_names.dart';
import '/core/dependency_injection.dart';
import '/core/interfaces/controller.dart';
import 'create_group_state.dart';
import '../home/home_state.dart';
import '../../core/classes/chat.dart';




// List<MapEntry<String, List<Map<int,String>>>> chats = [];



class CreateGroupController extends MainController {
  final CreateGroupState createGroupState = getIt<CreateGroupState>();
  final HomeState homeState = getIt<HomeState>();
  // final HubConnection connection = getIt<HubConnection>();
  final SignalRMessaging signalRMessaging = getIt<SignalRMessaging>();







  void createGroup(){
    // if(!homeState.chats.any((element) => element.chatName == createGroupState.groupName.text)) {
    //   homeState.chats.add(Chat(type: ChatType.group, chatName: createGroupState.groupName.text,
    //       messages: []));
    //   connection.invoke('AddToGroup', args: [createGroupState.groupName.text]);
    // }
    signalRMessaging.createGroup(newGroupName: createGroupState.groupName.text);
  }

  void backToHomeScreen(){
    myNavigator.goToName(RouteNames.newChat);
  }





}
