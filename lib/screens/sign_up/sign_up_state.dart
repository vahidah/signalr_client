import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import '/core/classes/airline_class.dart';
// import '/core/classes/flight_element_class.dart';
// import '/core/classes/flight_status_class.dart';
// import '/core/classes/home_notif_class.dart';
// import '/core/classes/login_class.dart';
// import '/core/classes/notif_class.dart';
// import '/core/classes/notif_type_class.dart';
// import '/core/util/moon_icons.dart';
// import '/core/util/utils.dart';

class SignUpState with ChangeNotifier {
  setState() => notifyListeners();

  File? image;

  void set setImage(File image) {

    this.image = image;
    notifyListeners();
  }




}