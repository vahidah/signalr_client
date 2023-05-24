import 'package:flutter/material.dart';
import 'package:get/get.dart';


class NewContactState with ChangeNotifier {
  setState() => notifyListeners();



  RxBool getContactInfoCompleted = true.obs;

  RxBool correctPhoneNumber = true.obs;

  TextEditingController contactPhoneController = TextEditingController();
}