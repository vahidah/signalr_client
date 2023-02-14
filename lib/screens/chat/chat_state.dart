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

  TextEditingController textController = TextEditingController();

  bool _showSendMessageIcon = false;

  bool get showSendMessageIcon => _showSendMessageIcon;

  set setShowSendMessageIcon(bool newValue){
    setState();
    _showSendMessageIcon  = newValue;
  }

  Chat? _selectedChat;

  set setChat(Chat newChat) {
    _selectedChat = newChat;

    notifyListeners();
    // todo test calling notify listeners at end



    // final itemPositionsList = itemPositionsListener.itemPositions.value.toList();
    //
    // int lastIndex = _selectedChat!.messages.length - 1;
    //
    // if(itemPositionsList.isNotEmpty){
    //   debugPrint("indexes : ${itemPositionsList.last.index}, $lastIndex");
    // }else{
    //   debugPrint("its empty");
    // }
    // if (itemPositionsList.isNotEmpty && lastIndex != itemPositionsList.last.index) {
    //   debugPrint("scroll jumped");
    //   debugPrint("${itemPositionsList.last.index}");
    //   debugPrint("$lastIndex");
    //   itemScrollController.scrollTo(index: lastIndex, duration: const Duration(microseconds: 400));
    // }
  }



  Chat get selectedChat => _selectedChat!;



}