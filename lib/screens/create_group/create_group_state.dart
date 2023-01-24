import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CreateGroupState with ChangeNotifier {
  setState() => notifyListeners();


  int myId = -1;
  String? firebaseToken;


  TextEditingController groupName = TextEditingController();


}