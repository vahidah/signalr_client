import 'package:flutter/material.dart';
import 'package:signalr_client/core/constants/ui.dart';

class PickImageButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onclick;
  final double width;

  const PickImageButton({Key? key, required this.icon, required this.title, required this.onclick, required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.only(left: 10),
      height: 45,
      child: ElevatedButton(
        onPressed: onclick,
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(ProjectColors.textBlackColorsType1),
            backgroundColor: MaterialStateProperty.all(ProjectColors.backGroundOrangeType1)),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
