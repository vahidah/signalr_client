import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/constants/ui.dart';

class ProjectTextField extends StatelessWidget {
  const ProjectTextField(
      {Key? key,
      this.contentPadding = const EdgeInsets.all(20),
      this.hintText,
      required this.controller,
      this.inputBorder,
      this.style = const TextStyle(
          decoration: TextDecoration.none, color: ProjectColors.fontWhite, fontWeight: FontWeight.bold)})
      : super(key: key);

  final EdgeInsets contentPadding;
  final String? hintText;
  final InputBorder? inputBorder;
  final TextEditingController controller;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: style,
      decoration: InputDecoration(
        contentPadding: contentPadding,
        border: inputBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: ProjectColors.fontWhite, width: 1),
            ),
        hintText: hintText,
      ),
      controller: controller,
    );
  }
}
