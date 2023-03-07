import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/constants/ui.dart';

class ProjectTextField extends StatelessWidget {
  const ProjectTextField(
      {Key? key,
      this.contentPadding = const EdgeInsets.all(20),
      this.hintText,
      required this.validate,
      this.errorText,
      required this.controller,
      this.inputBorder,
      this.style = const TextStyle(
          decoration: TextDecoration.none, color: ProjectColors.fontBlackColorType1, fontWeight: FontWeight.bold)})
      : super(key: key);

  final EdgeInsets contentPadding;
  final String? hintText;
  final InputBorder? inputBorder;
  final TextEditingController controller;
  final TextStyle style;
  final bool validate;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: style,
      decoration: InputDecoration(
        contentPadding: contentPadding,
          errorStyle: const TextStyle(fontSize: 15),
        border: inputBorder ??
            OutlineInputBorder(

              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: ProjectColors.fontWhite, width: 1),
            ),
        hintText: hintText,
        errorText: validate? null : errorText ,
      ),
      controller: controller,
    );
  }
}
