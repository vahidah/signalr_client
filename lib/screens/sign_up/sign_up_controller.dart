import 'dart:async';
import 'dart:core';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:signalr_client/core/constants/SpKeys.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messaging_signalr/messaging_signalr.dart';


import '../../core/constants/constant_values.dart';
import '../../core/navigation/navigation_service.dart';
import '../../core/util/package_snackbars.dart';
import '/core/constants/route_names.dart';
import '/core/dependency_injection.dart';
import '/core/interfaces/controller.dart';
import '../home/home_state.dart';
import 'sign_up_state.dart';
import 'sign_up_repository.dart';

class SignUpController extends MainController {
  final SignUpState signUpState = getIt<SignUpState>();
  final HomeState homeState = getIt<HomeState>();
  static final NavigationService navigationService = getIt<NavigationService>();
  final SignalRMessaging signalRMessaging = getIt<SignalRMessaging>();



  @override
  void onInit() {
    // TODO: implement onInit

    signUpState.phoneNumberController.addListener(() {

     if (RegExpressions.phoneNumber.hasMatch(signUpState.phoneNumberController.text) || signUpState.phoneNumberController.text.isEmpty ) {
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


  Future<void> signUpSignalrPackage() async{


      await signalRMessaging.signUp(image: signUpState.image,
          userName: signUpState.nameController.text, phoneNumber: signUpState.phoneNumberController.text,
        password: signUpState.passwordController.text
      );

  }

  void signUp() async {

    debugPrint("in signUp");

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
      showInputValidationError();
      return;
    }
    if(!RegExpressions.phoneNumber.hasMatch(signUpState.phoneNumberController.text)){
      signUpState.phoneValidate.value = false;
      showInputValidationError();
      return;
    }
    if(signUpState.passwordController.text.length < 8){
      showInputValidationError();
      signUpState.passwordValidate.value = false;

      return;
    }

    signUpState.setLoading = true;
    await signUpSignalrPackage();



  }

  void login() async {


    debugPrint("login function called");

    if(signUpState.phoneNumberController.text.isNotEmpty){
      signUpState.phoneValidate.value = true;
    }
    if(signUpState.passwordController.text.length >= 8){
      signUpState.passwordValidate.value = true;
    }

    if(!RegExpressions.phoneNumber.hasMatch(signUpState.phoneNumberController.text)){
      signUpState.phoneValidate.value = false;
      showInputValidationError();
      return;
    }
    if(signUpState.passwordController.text.length < 8){
      showInputValidationError();
      signUpState.passwordValidate.value = false;
      return;
    }


    debugPrint("set loading value");

    signUpState.setLoading = true;

    debugPrint("call package login");

    signalRMessaging.login(phoneNumber: signUpState.phoneNumberController.text,
        password: signUpState.passwordController.text, fireBaseToken: ConstValues.fireBaseToken);



  }

  Future pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);

    if (image != null) {
      signUpState.setImage = File(image.path);
    }
  }

  void showInputValidationError(){
    PackageHintSnackBar.showSnackBar("Please enter the requested items correctly", true);
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }


}
