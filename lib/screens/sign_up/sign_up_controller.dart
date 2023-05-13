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

    signUpState.phoneNumberController.addListener(() {
      String regexPattern = r'^(?:[+0][1-9])?[0-9]{10,12}$';
      var regExp = RegExp(regexPattern);
     if (regExp.hasMatch(signUpState.phoneNumberController.text) || signUpState.phoneNumberController.text.isEmpty ) {
       signUpState.phoneValidate.value = true;
     }else{
       signUpState.phoneValidate.value = false;
     }

    });

    super.onInit();
  }

  void backToNewChatScreen() {
    nav.goToName(RouteNames.newChat);
  }


  Future<void> sendContactNameSignalrPackage() async{

    try{
      await signalRMessaging.loginToServer(image: signUpState.image,
          userName: signUpState.nameController.text, phoneNumber: int.parse(signUpState.phoneNumberController.text,),
        password: signUpState.passwordController.text
      );
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

    if(signUpState.nameController.text.isNotEmpty){
      signUpState.nameValidate.value = true;
    }
    if(signUpState.phoneNumberController.text.isNotEmpty){
      signUpState.phoneValidate.value = true;
    }
    if(signUpState.passwordController.text.length >= 8){
      signUpState.passwordValidate.value = true;
    }

    if(signUpState.nameController.text.isEmpty){
      signUpState.nameValidate.value = false;
      return;
    }
    if(signUpState.phoneNumberController.text.isEmpty){
      signUpState.phoneValidate.value = false;
      return;
    }
    if(signUpState.passwordController.text.length < 8){
      signUpState.passwordValidate.value = false;
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
