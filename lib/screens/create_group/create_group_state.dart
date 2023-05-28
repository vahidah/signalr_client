import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CreateGroupState with ChangeNotifier {
  setState() => notifyListeners();




  TextEditingController groupNameController = TextEditingController();


  RxBool showError = false.obs;

  bool _createGroupCompleted = true;

  bool get createGroupCompleted => _createGroupCompleted;

  set setCreateGroupCompleted(bool newValue){
    _createGroupCompleted = newValue;
    notifyListeners();
  }




}