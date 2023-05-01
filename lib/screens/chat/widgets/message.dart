import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as intel;

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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            color: clientMessage ? ProjectColors.backGroundOrangeType4 : ProjectColors.backGroundWhiteType1,
            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                chatType == ChatType.group && !clientMessage
                    ? Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 7),
                  child: Text(
                    message.senderUserName,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    //,
                  ),
                )
                    : const SizedBox(
                  width: 0,
                  height: 0,
                ),

                Row(

                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 8, right: 0, left: 10),
                          child: Text(
                            message.text,
                            style: const TextStyle(fontSize: 18),
                            softWrap: true,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10, left: 2, ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text( intel.DateFormat('kk:mm').format(message.date!),
                            //its work as this app is memory less
                            style: TextStyle(color: clientMessage ? ProjectColors.fontOrange : ProjectColors.fontGray, fontSize: 13),),
                          const SizedBox(
                            width: 5,
                          ),
                          clientMessage ? const Icon(Icons.done_all, size: 20, color: ProjectColors.fontOrange,) : Container()
                        ],
                      ),
                    ),
                  ],
                ),

              ],
            )
        ),
      ),
    );
  }
}
