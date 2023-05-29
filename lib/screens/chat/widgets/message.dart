import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as intel;

import 'package:flutter/material.dart';
import 'package:messaging_signalr/messaging_signalr.dart';
import 'package:messaging_signalr/data_base/model_message.dart';
import 'package:signalr_client/core/constants/ui.dart';
import 'package:signalr_client/screens/chat/widgets/message_date.dart';


class MessageWidget extends StatefulWidget {
  const MessageWidget({Key? key, required this.clientMessage, required this.chatType, required this.message})
      : super(key: key);
  final bool clientMessage;
  final ChatType chatType;
  final Message message;

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {

  final dateKey = GlobalKey();
  final rowKey = GlobalKey();

  bool multilineText = false;

  double? availableWidthForText;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {

      if(rowKey.currentContext != null) {
        availableWidthForText = rowKey.currentContext!.size!.width - dateKey.currentContext!.size!.width - 15;


        String textTest = widget.message.message;
        final span=TextSpan(text:textTest );
        final tp =TextPainter(text:span,maxLines: 1,textDirection: TextDirection.ltr);
        tp.layout(maxWidth: availableWidthForText?? 0); // equals the parent screen width


        setState(() {
          if(tp.didExceedMaxLines) {
            multilineText = true;
          }
        });
      }else{
        multilineText = true;
      }



    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Align(
      alignment: widget.clientMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 100,
        ),
        child: Row(
          children: [
            Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                margin: EdgeInsets.only(top: 5, bottom: 5 ,
                    left: widget.clientMessage ? 0 : 10, right: widget.clientMessage ? 10 : 0),
                color: widget.clientMessage ? ProjectColors.backGroundOrangeType4 : ProjectColors.backGroundWhiteType1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.chatType == ChatType.group && !widget.clientMessage
                        ? Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 7, right: 10.0),
                      child: Text(
                        widget.message.senderUserName,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        //,
                      ),
                    )
                        : const SizedBox(
                      width: 0,
                      height: 0,
                    ),
                  multilineText == false ?
                    Row(
                      key: rowKey,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 4, right: 5, left: 10),
                              child:TextWidget(text: widget.message.message)),
                        ),
                        Padding(
                          key: dateKey,
                          padding: const EdgeInsets.only(right: 10, left: 2, ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text( intel.DateFormat('kk:mm').format(widget.message.date!),
                                //its work as this app is memory less
                                style: TextStyle(color: widget.clientMessage ? ProjectColors.fontOrange : ProjectColors.fontGray, fontSize: 13),),
                              const SizedBox(
                                width: 5,
                              ),
                              widget.clientMessage ? const Icon(Icons.done_all, size: 20, color: ProjectColors.fontOrange,) : Container()
                            ],
                          ),
                        ),
                      ],
                    )
                      : Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(top: 5, left: 10, right:10),
                          child:TextWidget(text: widget.message.message)),
                      MessageDate(date: widget.message.date!, clientMessage: widget.clientMessage, ),
                    ],
                  ),

                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}

class TextWidget extends StatelessWidget {
  TextWidget({Key? key, required this.text,}) : super(key: key);

  String text;


  @override
  Widget build(BuildContext context) {

    return Text(
      text,
      style: const TextStyle(fontSize: 18),
      softWrap: true,
    );
  }
}

class MessageDate extends StatelessWidget {
  MessageDate({Key? inputKey, required this.date, required this.clientMessage}) : super(key: inputKey);

  bool clientMessage;
  DateTime date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: key,
      padding: const EdgeInsets.only(right: 10, left: 2, ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text( intel.DateFormat('kk:mm').format(date),
            //its work as this app is memory less
            style: TextStyle(color: clientMessage ? ProjectColors.fontOrange : ProjectColors.fontGray, fontSize: 13),),
          const SizedBox(
            width: 5,
          ),
          clientMessage ? const Icon(Icons.done_all, size: 20, color: ProjectColors.fontOrange,) : Container()
        ],
      ),
    );
  }
}


