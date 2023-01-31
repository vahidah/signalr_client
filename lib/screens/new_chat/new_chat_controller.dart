
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
    myNavigator.goToName(RouteNames.home);
  }
  void goToNewContactScreen(){
    myNavigator.goToName(RouteNames.newContact);
  }
  void goToCreateGroupScreen(){
    myNavigator.goToName(RouteNames.createGroup);
  }





}
