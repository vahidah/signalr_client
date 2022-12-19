import 'package:intl/intl.dart';


import 'package:flutter/material.dart';
import '../../../core/classes/chat.dart';
import '../../../core/classes/message.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({Key? key, required this.clientMessage, required this.messageText,
    required this.chatType, required this.senderId, required this.date, required this.senderUserName}) : super(key: key);
  final bool clientMessage;
  final ChatType chatType;
  final int senderId;
  final String messageText;
  final DateTime date;
  final String senderUserName;
  // final int clientId;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: clientMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 100,
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
          ),
            margin: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
            color: clientMessage ? Color(0xffdcf8c6) : Colors.white ,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                chatType == ChatType.group && !clientMessage ? Padding(
                  padding: const EdgeInsets.only(left:10.0, top:7),
                  child: Text(senderUserName, style: TextStyle(fontSize: 20 ,fontWeight: FontWeight.bold),),
                ) : const SizedBox(width: 0, height: 0,),
                Padding(
                  padding: const EdgeInsets.only(top: 7, bottom: 7, right: 16, left: 10),
                  child: Text(messageText, style: TextStyle(fontSize: 16),),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10, bottom: 3),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(DateFormat('yyyy-MM-dd – kk:mm').format(date), style: TextStyle(color: Colors.grey, fontSize: 13),),
                        SizedBox(width: 5,),
                        clientMessage? Icon(Icons.done_all): Container()],
                    ),
                  ),
                )
              ],
            )
            // Stack(
            //   children: [
            //     Text("hey"),
            //     Row(
            //       children: [
            //         Text("20:58"),
            //         Icon(Icons.done_all)
            //       ],
            //     )
            //   ],
            // ),
            ),
      ),
    );
  }
}
