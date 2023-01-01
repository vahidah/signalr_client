
import 'dart:io';
import 'dart:ui';

import 'message.dart';


class Chat{

  Chat({required this.type, required this.chatName, required this.messages,this.image ,this.userName});

  ChatType type;
  List<Message> messages = [];
  String chatName;
  String? image;
  String? userName;

}


enum ChatType {
  group,
  contact,
}