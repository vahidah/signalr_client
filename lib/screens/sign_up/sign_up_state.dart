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

  bool _loading = false;

  set setLoading(bool newValue) {

    _loading = newValue;
    notifyListeners();
  }

  bool? get loading => _loading;

  TextEditingController nameController = TextEditingController();

  // void setLoading(bool newValue) {
  //   _loading = newValue;
  //   setState();
  // }



}