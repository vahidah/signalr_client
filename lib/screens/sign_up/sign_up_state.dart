import 'dart:io';
import 'package:flutter/material.dart';



class SignUpState with ChangeNotifier {
  setState() => notifyListeners();

  File? _image;

  set setImage(File image) {

    _image = image;
    notifyListeners();
  }

  File? get image => _image;

  TextEditingController nameController = TextEditingController();


}