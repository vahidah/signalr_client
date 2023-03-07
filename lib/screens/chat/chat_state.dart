import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:messaging_signalr/messaging_signalr.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ChatState with ChangeNotifier {
  setState() => notifyListeners();



  RxString chatKey = ('').obs;
  // Rx<Chat>? chat;
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  TextEditingController textMessageController = TextEditingController();
  TextEditingController emojiController = TextEditingController();

  FocusNode textInputFocus = FocusNode();

  bool _showSendMessageIcon = false;

  bool get showSendMessageIcon => _showSendMessageIcon;

  set setShowSendMessageIcon(bool newValue){
    _showSendMessageIcon  = newValue;
    setState();
  }

  bool _emojiPickerVisible = true;

  bool get emojiPickerVisible => _emojiPickerVisible;

  set setEmojiPickerVisible(bool newValue){
    _emojiPickerVisible  = newValue;
    setState();
  }

  // bool _isKeyBoardVisible = false;
  //
  // bool get isKeyBoardVisible => _isKeyBoardVisible;
  //
  // set isKeyBoardVisible(bool newValue){
  //   setState();
  //   _isKeyBoardVisible  = newValue;
  // }

  Chat? _selectedChat;

  set setChat(Chat newChat) {
    _selectedChat = newChat;

    notifyListeners();
    // todo test calling notify listeners at end


  }



  Chat? get selectedChat => _selectedChat;



}