



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../core/constants/ui.dart';

class TextFieldSignUp extends StatelessWidget {
  const TextFieldSignUp({Key? key, required this.icon, required this.title,
    required this.controller, required this.validate, required this.errorMessage}) : super(key: key);

  final IconData icon;
  final String title;
  final String errorMessage;
  final TextEditingController controller;
  final RxBool validate;



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 50,
            width: 50,
            color: ProjectColors.backGroundOrangeType3,
            child: const Center(
              child: Icon(
                Icons.person,
                size: 29,
                color: ProjectColors.fontWhite,
              ),
            ),
          ),
          Container(
            width: 260,
            height: 50,
            color: ProjectColors.backGroundWhiteType1,
            //const Color.fromRGBO(255, 165, 0, 1),
            child: Obx ( () => TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 10, top: 5),
                border: InputBorder.none,
                hintText: title,
                hintStyle: const TextStyle(color: ProjectColors.fontBlackColorType1),
                //const TextStyle(color: ProjectColors.fontBlackColorType1),
                errorText: validate.value ? null : errorMessage,

              ),
              controller: controller,
            )),
          )
        ],
      ),
    );
  }
}
