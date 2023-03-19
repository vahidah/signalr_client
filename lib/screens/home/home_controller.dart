
import 'dart:core';
import 'package:get/get.dart';
import 'package:signalr_core/signalr_core.dart';

import '../chat/chat_state.dart';
import '/core/constants/route_names.dart';
import '/core/dependency_injection.dart';
import '/core/interfaces/controller.dart';
import 'home_state.dart';



class HomeController extends MainController {
  final HomeState homeState = getIt<HomeState>();
  final ChatState chatState = getIt<ChatState>();



  void goToChatScreen(String chatKey){

    chatState.chatKey.value = chatKey;
    nav.goToName(RouteNames.chat);
  }
  void goToNewChatScreen(){
    nav.goToName(RouteNames.newChat);
  }

  String firstPartOfChat(String str){
    return str.length > 15 ? "${str.substring(0,14)}..." : str;
  }

  onSearch(String searched){



  }


}
