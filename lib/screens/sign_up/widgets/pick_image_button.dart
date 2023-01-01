



import 'package:flutter/material.dart';

Widget pickImageButton({
  required IconData icon,
  required String title,
  required VoidCallback onclick,
  required double width
}){


  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Container(
      width: width,
      padding: EdgeInsets.only(left: 10),
      height: 45,
      child: ElevatedButton(
        onPressed: onclick,
        style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.white)),
        child: Row(
          children: [
            Icon(icon),
            SizedBox(width: 10,),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    ),
  );

}