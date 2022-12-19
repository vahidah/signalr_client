
import 'message.dart';

class Chat{

  Chat({required this.type, required this.chatName, required this.messages, this.userName});

  ChatType type;
  List<Message> messages = [];
  String chatName;
  String? userName;

}


enum ChatType {
  group,
  contact,
}