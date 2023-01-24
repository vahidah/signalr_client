import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/classes/chat.dart';

// import '/core/classes/airline_class.dart';
// import '/core/classes/flight_element_class.dart';
// import '/core/classes/flight_status_class.dart';
// import '/core/classes/home_notif_class.dart';
// import '/core/classes/login_class.dart';
// import '/core/classes/notif_class.dart';
// import '/core/classes/notif_type_class.dart';
// import '/core/util/moon_icons.dart';
// import '/core/util/utils.dart';

class HomeState with ChangeNotifier {
  setState() => notifyListeners();



  int myId = -1;
  String? userName;
  RxBool userNameReceived = true.obs;
  int imageIndex = -1;


  List<Chat> chats = [];
  //todo add getter and setter



  RxBool rebuildChatList = false.obs;
  RxBool idReceived = false.obs;



}