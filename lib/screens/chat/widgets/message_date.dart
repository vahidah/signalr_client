import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:signalr_client/core/constants/ui.dart';

class ChatDate extends StatelessWidget {
  const ChatDate({Key? key, required this.date}) : super(key: key);

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(border: Border.all(width: 0, color: ProjectColors.backGroundBlackType3), borderRadius: BorderRadius.circular(10),color: ProjectColors.backGroundBlackType3),
          child:
          Text(
             DateFormat(date.day > 9 ? 'MMMM dd' : 'MMMM d').format(date),
            style: const TextStyle(color: ProjectColors.fontWhite, fontSize: 15),
          ),
        ),
      ],
    );
  }
}
