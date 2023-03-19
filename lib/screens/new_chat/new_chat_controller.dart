
import 'dart:core';


import '../../core/constants/route_names.dart';
import '/core/dependency_injection.dart';
import '/core/interfaces/controller.dart';

import 'new_chat_state.dart';



class NewChatController extends MainController {
  final NewChatState chatState = getIt<NewChatState>();
  // final HomeRepository homeRepository = getIt<HomeRepository>();





  //
  // void sendMessageToContact(){
  //   // connection.invoke('sendMessage', args: [int.parse(id.text), message.text]);
  // }
  void backToHomeScreen(){
    nav.goToName(RouteNames.home);
  }
  void goToNewContactScreen(){
    nav.goToName(RouteNames.newContact);
  }
  void goToCreateGroupScreen(){
    nav.goToName(RouteNames.createGroup);
  }





}
