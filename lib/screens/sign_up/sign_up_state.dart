import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



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

  bool get loading => _loading;


  RxBool nameValidate = true.obs;
  RxBool phoneValidate = true.obs;

  RxBool checkBoxValue = true.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();




}