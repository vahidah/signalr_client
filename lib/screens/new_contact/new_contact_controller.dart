import 'dart:convert';
import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:signalr_client/screens/new_contact/new_contact_repositroy.dart';
import 'package:signalr_client/screens/new_contact/usecases/get_image_usecase.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:intl/intl.dart';

import '../../core/util/failure_handler.dart';
import '../sign_up/usecases/image_usecase.dart';
import '/core/constants/apis.dart';
import '/core/constants/route_names.dart';
import '/core/dependency_injection.dart';
import '/core/interfaces/controller.dart';
import '../home/home_state.dart';
import 'new_contact_state.dart';
import '../../core/classes/chat.dart';
import '../../core/classes/message.dart';

class NewContactController extends MainController {
  final NewContactState newContactState = getIt<NewContactState>();
  final HomeState homeState = getIt<HomeState>();
  final connection = getIt<HubConnection>();

  final NewContactRepository newContactRepository = getIt<NewContactRepository>();
  late GetImageUseCase getImageUseCase = GetImageUseCase(repository: newContactRepository);

  String? base64Image;

  @override
  void onInit({dynamic args}) {}

  void backToNewChatScreen() {
    myNavigator.goToName(RouteNames.newChat);
  }

  void getImage()async{
    GetImageRequest imageRequest = GetImageRequest(contactId: int.parse(newContactState.contactId.text));
    final result = await getImageUseCase(request: imageRequest);
    result.fold((failure) => FailureHandler.handle(failure, retry: () => getImage()), (r) => {base64Image = r});
  }

  void sendFirstMessage() async {
    //  debugPrint("here send first message");

    //
    //  debugPrint("contact id is : ${int.parse(contactId.text)}");
    //  http.Response response = await http.post(
    //      Uri.parse("${Apis.getImage}/${int.parse(contactId.text)}",),
    //
    //  );
    // // final response = await dio.post("${apis}${int.parse(contactId.text)}");
    // // response.data.
    //  base64Image = base64.encode(response.bodyBytes);
    getImage();
    homeState.chats.insert(
        0,
        Chat(
            type: ChatType.contact,
            chatName: newContactState.contactId.text,
            messages: [
              Message(
                  sender: homeState.myId, text: newContactState.firstMessage.text, senderUserName: homeState.userName!)
            ],
            image: base64Image));
    connection.invoke('sendMessage',
        args: [int.parse(newContactState.contactId.text), newContactState.firstMessage.text, true]);

    homeState.rebuildChatList.toggle();
  }
}
