import 'package:flutter/material.dart';

import '../../../core/constants/ui.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key, required this.title, required this.bottomPadding, required this.onTap})
      : super(key: key);

  final String title;
  final double bottomPadding;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 50,
        width: 300,
        margin: EdgeInsets.only(
          bottom: bottomPadding,
        ),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            stops: [0.7, 1],
            colors: [
              ProjectColors.backGroundHalfTransparentType1,
              ProjectColors.backGroundBlackType1,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
          border: Border.all(color: ProjectColors.backGroundHalfTransparentType1, width: 0),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
          // color: ProjectColors.backGroundHalfTransparentType1
        ),
        child: Center(
            child: Text(
          title,
          style: const TextStyle(color: ProjectColors.fontBlackColorType1, fontSize: 20),
          //style: TextStyle(color: ProjectColors.fontBlackColorType1, fontSize: 20)
        )),
      ),
    );
  }
}
