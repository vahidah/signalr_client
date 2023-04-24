

import 'package:flutter/material.dart';

import '../core/constants/ui.dart';

class BackButtonLocal extends StatelessWidget {
  const BackButtonLocal({Key? key, required this.onTap, required this.color, required this.size}) : super(key: key);

  final Function() onTap;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(Icons.arrow_back, color: color, size: size,),
    );
  }
}
