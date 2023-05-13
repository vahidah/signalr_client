


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../sign_up_state.dart';
import '/core/constants/ui.dart';


class LoginButton extends StatelessWidget {
  const LoginButton({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    SignUpState state = context.watch<SignUpState>();
    return Container(
      decoration: BoxDecoration(
        color: ProjectColors.backGroundWhiteType1 ,
        border: Border.all(width: 1, color: ProjectColors.fontWhite),
        borderRadius: BorderRadius.circular(30)),
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.1,
      child: TextButton(
        onPressed: (){
          state.setIndexStack = 1;
        },
        child: Center(child: Text(title, style: TextStyle( fontSize: 20, color: ProjectColors.fontOrange),)),
      ),
    );
  }
}
