



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../core/constants/ui.dart';

class TextFieldSignUp extends StatelessWidget {
  TextFieldSignUp({Key? key, required this.icon, required this.title,
    required this.controller, required this.validate, required this.errorMessage, this.password = false}) : super(key: key);

  final IconData icon;
  final String title;
  final String errorMessage;
  final TextEditingController controller;
  final RxBool validate;
  final bool password;

  final RxBool obscureText = true.obs;



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
            child: Center(
              child: Icon(
                icon,
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

              obscureText: password? obscureText.value : false,
              decoration: InputDecoration(
                suffixIconConstraints: const BoxConstraints(maxHeight: 20),
                suffixIcon: password? HideButton(hide: obscureText) : null,
                contentPadding: EdgeInsets.only(left: 10),
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


class HideButton extends StatelessWidget {
  const HideButton({Key? key, required this.hide}) : super(key: key);

  final RxBool hide;

  @override
  Widget build(BuildContext context) {
    return Obx( () => IconButton(
        onPressed: () => hide.toggle(),
        padding: EdgeInsetsDirectional.only(end: 12 ),
        icon: Icon(hide.value? Icons.visibility : Icons.visibility_off, color: Colors.black, )
    ));
  }
}

