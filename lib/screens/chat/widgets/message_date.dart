import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:signalr_client/core/constants/ui.dart';

class MessageDate extends StatelessWidget {
  const MessageDate({Key? key, required this.date}) : super(key: key);

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(border: Border.all(width: 0, color: ProjectColors.backGroundBlackType3), borderRadius: BorderRadius.circular(10),color: ProjectColors.backGroundBlackType3),
          child: Center(
              child: Text(
            DateFormat('MMMM dd').format(date),
            style: const TextStyle(color: ProjectColors.fontWhite, fontSize: 18),
          )),
        ),
      ],
    );
  }
}
