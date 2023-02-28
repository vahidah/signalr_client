import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:messaging_signalr/messaging_signalr.dart';
import 'package:signalr_client/core/constants/ui.dart';
import '../../../core/classes/chat.dart';
import '../../../core/classes/message.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({Key? key, required this.clientMessage, required this.chatType, required this.message})
      : super(key: key);
  final bool clientMessage;
  final ChatType chatType;
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: clientMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 100,
        ),
        child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            color: clientMessage ? ProjectColors.ownMessageText : ProjectColors.fontWhite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                chatType == ChatType.group && !clientMessage
                    ? Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 7),
                        child: Text(
                          message.senderUserName,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      )
                    : const SizedBox(
                        width: 0,
                        height: 0,
                      ),
                Padding(
                  padding: const EdgeInsets.only(top: 7, bottom: 7, right: 16, left: 10),
                  child: Text(
                    message.text,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10, bottom: 3),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          DateTime.now().day > message.date!.day
                              ? DateFormat('yyyy-MM-dd – kk:mm').format(message.date!)
                              : DateFormat('kk:mm').format(message.date!),
                          //its work as this app is memory less
                          style: const TextStyle(color: ProjectColors.fontGrayHome, fontSize: 13),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        clientMessage ? const Icon(Icons.done_all, size: 20,) : Container()
                      ],
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
