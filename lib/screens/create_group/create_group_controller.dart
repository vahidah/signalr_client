import 'dart:convert';
import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'package:messaging_signalr/messaging_signalr.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/navigation/navigation_service.dart';
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
  static final NavigationService navigationService = getIt<NavigationService>();
  final SignalRMessaging signalRMessaging = getIt<SignalRMessaging>();




  @override
  void onInit() {
    // TODO: implement onInit
    createGroupState.groupNameController.clear();

    createGroupState.groupNameController.addListener(() {
      debugPrint("listener called1");
      if(createGroupState.groupNameController.text.isNotEmpty){
        createGroupState.showError.value = false;
      }
      //is this way true or it cause to page get built with no reason
    });

    super.onInit();
  }


  void createGroup() async{
    // if(!homeState.chats.any((element) => element.chatName == createGroupState.groupName.text)) {
    //   homeState.chats.add(Chat(type: ChatType.group, chatName: createGroupState.groupName.text,
    //       messages: []));
    //   connection.invoke('AddToGroup', args: [createGroupState.groupName.text]);
    // }
    if(createGroupState.groupNameController.text.isEmpty){
      createGroupState.showError.value = true;
      return;
    }
    createGroupState.setCreateGroupCompleted = false;
    debugPrint("create group1");
    await signalRMessaging.createGroup(newGroupName: createGroupState.groupNameController.text);
    debugPrint("create group2");
    createGroupState.setCreateGroupCompleted = true;
    // navigationService.snackBar(content)
  }

  void backToHomeScreen(){
    nav.goToName(RouteNames.newChat);
  }





}
