import 'package:flutter/material.dart';
import 'package:get/get.dart';


class NewContactState with ChangeNotifier {
  setState() => notifyListeners();

  RxBool userNameReceived = true.obs;


  TextEditingController contactId = TextEditingController();
  TextEditingController firstMessage = TextEditingController();
}