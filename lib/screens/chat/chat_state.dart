import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import '../../core/classes/chat.dart';
import 'package:messaging_signalr/messaging_signalr.dart';

class ChatState with ChangeNotifier {
  setState() => notifyListeners();



  RxString? chatKey;
  // Rx<Chat>? chat;


  TextEditingController textController = TextEditingController();

  bool _showSendMessageIcon = false;

  bool get showSendMessageIcon => _showSendMessageIcon;

  set setShowSendMessageIcon(bool newValue){
    setState();
    _showSendMessageIcon  = newValue;
  }



}