import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CreateGroupState with ChangeNotifier {
  setState() => notifyListeners();




  TextEditingController groupName = TextEditingController();


  bool _createGroupCompleted = true;

  bool get createGroupCompleted => _createGroupCompleted;

  set setCrateGroupCompleted(bool newValue){
    _createGroupCompleted = newValue;
    notifyListeners();
  }




}