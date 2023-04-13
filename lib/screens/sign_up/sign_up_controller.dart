import 'dart:async';
import 'dart:core';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signalr_client/core/constants/SpKeys.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messaging_signalr/messaging_signalr.dart';


import '../../core/navigation/navigation_service.dart';
import '/core/constants/route_names.dart';
import '/core/dependency_injection.dart';
import '/core/interfaces/controller.dart';
import '../home/home_state.dart';
import 'sign_up_state.dart';
import 'sign_up_repository.dart';

class SignUpController extends MainController {
  final SignUpState signUpState = getIt<SignUpState>();
  final HomeState homeState = getIt<HomeState>();
  final SignupRepository signupRepository = getIt<SignupRepository>();
  static final NavigationService navigationService = getIt<NavigationService>();
  final SignalRMessaging signalRMessaging = getIt<SignalRMessaging>();



  @override
  void onInit() {
    // TODO: implement onInit

    signUpState.nameController.addListener(() {
      debugPrint("listener called");
      if(signUpState.nameController.text.isNotEmpty) {
        signUpState.validate.value = true;
      }
    });

    super.onInit();
  }

  void backToNewChatScreen() {
    nav.goToName(RouteNames.newChat);
  }


  Future<void> sendContactNameSignalrPackage() async{
    //
    try{
      await signalRMessaging.sendUserName(image: signUpState.image, userName: signUpState.nameController.text);
    }catch(e, t){
      navigationService.snackBar(GestureDetector(
          onTap: (){
            // AppB
          },
          child: const Text("upload image failed")),
          icon: Icons.error,
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 20),
          action: SnackBarAction(
            textColor: Colors.white,
            label: "Retry",
            onPressed: () {
              log("Retry");
              sendContactName();
            },
          ));
    }
  }

  void sendContactName() async {


    if(signUpState.nameController.text.isEmpty){
      signUpState.validate.toggle();
      return;

    }

    signUpState.setLoading = true;
    await sendContactNameSignalrPackage();
    prefs.setInt(SpKeys.signalrId, signalRMessaging.myId);
    prefs.setString(SpKeys.username, signalRMessaging.userName!);

    nav.goToName(RouteNames.home);
    signUpState.setLoading = false;


  }

  Future pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);

    if (image != null) {
      signUpState.setImage = File(image.path);
    }
  }


}
