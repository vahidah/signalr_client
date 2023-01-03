import 'dart:convert';
import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// import '/core/classes/flight_element_class.dart';
// import '/core/classes/login_class.dart';
// import '/core/constants/assets.dart';
import '/core/constants/route_names.dart';
// import '/core/constants/share_preferences_keys.dart';
import '/core/constants/ui.dart';
import '/core/dependency_injection.dart';
import '/core/interfaces/controller.dart';
import '../../main.dart';
import '../home/home_state.dart';
import '/core/util/failure_handler.dart';
// import '/core/util/moon_icons.dart';
// import '/core/util/utils.dart';
// import '/widgets/calendar_pop_up.dart';
// import '/widgets/snack_bar_widget.dart';
// import '/widgets/top_dialog_bar.dart';
// import '../usecases/flight_list_usecase.dart';
// import '../usecases/flight_status_list_usecase.dart';
import 'sign_up_state.dart';
import 'sign_up_repository.dart';
import 'usecases/image_usecase.dart';
import '../home/home_state.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:http/io_client.dart';
import '../../core/classes/chat.dart';
import '../../core/classes/message.dart';



// List<MapEntry<String, List<Map<int,String>>>> chats = [];



class SignUpController extends MainController {
  final SignUpState signUpState = getIt<SignUpState>();
  final HomeState homeState = getIt<HomeState>();
  final SignupRepository signupRepository = getIt<SignupRepository>();

  late ImageUseCase imageUseCaseUse = ImageUseCase(repository: signupRepository);


  TextEditingController nameController = TextEditingController();

  File? image;

  @override
  void onInit({dynamic args}) {

  }
  //
  // void sendMessageToContact(){
  //   // connection.invoke('sendMessage', args: [int.parse(id.text), message.text]);
  // }
  void backToNewChatScreen(){
    myNavigator.goToName(RouteNames.newChat);
  }

  void sendContactName() async{
    // ImageRequest imageRequest = ImageRequest(id: homeState.myId, image: image!);
    // final result = await imageUseCaseUse(request: imageRequest);
    // debugPrint("result of uploading image is: ${result}");
    homeState.userName = nameController.text;
    debugPrint("sending user name ${nameController.text}");
    connection.invoke('ReceiveUserName', args: [nameController.text, homeState.myId]);
    myNavigator.goToName(RouteNames.home);
  }





}