import 'dart:convert';
import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:signalr_core/signalr_core.dart';

import '../../core/util/failure_handler.dart';
import '/core/constants/route_names.dart';
import '/core/dependency_injection.dart';
import '/core/interfaces/controller.dart';
import '../home/home_state.dart';
import 'sign_up_state.dart';
import 'sign_up_repository.dart';
import 'usecases/image_usecase.dart';

class SignUpController extends MainController {
  final SignUpState signUpState = getIt<SignUpState>();
  final HomeState homeState = getIt<HomeState>();
  final SignupRepository signupRepository = getIt<SignupRepository>();
  final connection = getIt<HubConnection>();
  late ImageUseCase imageUseCaseUse = ImageUseCase(repository: signupRepository);



  @override
  void onCreate() {

    super.onCreate();
  }

  @override
  void onInit({dynamic args}) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  void backToNewChatScreen() {
    myNavigator.goToName(RouteNames.newChat);
  }

  void uploadImage() async{
    ImageRequest imageRequest = ImageRequest(id: homeState.myId, image: signUpState.image!);
    final result = await imageUseCaseUse(request: imageRequest);
    result.fold(
            (failure) =>
            FailureHandler.handle(failure, retry: () => uploadImage()),
            (r) {});
    debugPrint("result of uploading image is: $result");
  }

  void sendContactName() async {

    homeState.userName = signUpState.nameController.text;
    debugPrint("sending user name ${signUpState.nameController.text}");
    connection.invoke('ReceiveUserName', args: [signUpState.nameController.text, homeState.myId]);
    myNavigator.goToName(RouteNames.home);
  }

  Future pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);

    if (image != null) {
      signUpState.setImage = File(image.path);
    }
  }
}
