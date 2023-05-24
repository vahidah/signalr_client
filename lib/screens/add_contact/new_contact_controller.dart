
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dartz/dartz.dart';
import 'package:messaging_signalr/messaging_signalr.dart';
import 'package:signalr_client/screens/add_contact/new_contact_repositroy.dart';
import 'package:signalr_client/screens/add_contact/usecases/get_image_usecase.dart';
import 'package:signalr_core/signalr_core.dart';

import '../../core/constants/constant_values.dart';
import '../../core/navigation/navigation_service.dart';
import '../../core/util/package_snackbars.dart';
import '/core/constants/route_names.dart';
import '/core/dependency_injection.dart';
import '/core/interfaces/controller.dart';
import '../home/home_state.dart';
import 'new_contact_state.dart';


class NewContactController extends MainController {
  final NewContactState newContactState = getIt<NewContactState>();
  final HomeState homeState = getIt<HomeState>();
  final SignalRMessaging signalRMessaging = getIt<SignalRMessaging>();

  final NewContactRepository newContactRepository = getIt<NewContactRepository>();
  late GetImageUseCase getImageUseCase = GetImageUseCase(repository: newContactRepository);


  @override
  void onInit() {

    newContactState.contactPhoneController.clear();


    newContactState.contactPhoneController.addListener(() {

      int contactLength = newContactState.contactPhoneController.text.length;
      debugPrint("in listener");
      if(newContactState.contactPhoneController.text.isNum && (contactLength>=10 && contactLength<=12)){
        newContactState.correctPhoneNumber.value = true;
      }
    });

    super.onInit();
  }


  void backToNewChatScreen() {
    nav.goToName(RouteNames.newChat);
  }


  void addNewContact() async {

    if(!RegExpressions.phoneNumber.hasMatch(newContactState.contactPhoneController.text) ){
      newContactState.correctPhoneNumber.value = false;
      return;
    }


    debugPrint("sending First Message to contact");
    newContactState.getContactInfoCompleted.toggle();

    await signalRMessaging.addNewContact(contactPhoneNumber: newContactState.contactPhoneController.text);

    newContactState.contactPhoneController.clear();

    }

}
