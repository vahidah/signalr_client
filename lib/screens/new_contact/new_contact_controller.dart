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
  final NewContactState chatState = getIt<NewContactState>();
  final HomeState homeState = getIt<HomeState>();
  final connection = getIt<HubConnection>();

  final NewContactRepository newContactRepository = getIt<NewContactRepository>();
  late GetImageUseCase getImageUseCase = GetImageUseCase(repository: newContactRepository);



  TextEditingController contactId = TextEditingController();
  TextEditingController firstMessage = TextEditingController();


  @override
  void onInit({dynamic args}) {

  }

  void backToNewChatScreen(){
    myNavigator.goToName(RouteNames.newChat);
  }

  void sendFirstMessage() async{
     //  debugPrint("here send first message");
      String? base64Image;
     //
     //  debugPrint("contact id is : ${int.parse(contactId.text)}");
     //  http.Response response = await http.post(
     //      Uri.parse("${Apis.getImage}/${int.parse(contactId.text)}",),
     //
     //  );
     // // final response = await dio.post("${apis}${int.parse(contactId.text)}");
     // // response.data.
     //  base64Image = base64.encode(response.bodyBytes);
      GetImageRequest imageRequest = GetImageRequest(contactId:int.parse(contactId.text));
      final result = await getImageUseCase(request: imageRequest);
      result.fold((failure) =>
          FailureHandler.handle(failure, retry: () => {}),
              (r) => {base64Image = r});
     homeState.userNameReceived.toggle();
      debugPrint("value is: ${homeState.userNameReceived.toggle()}");
      homeState.chats.insert(0, Chat(type: ChatType.contact, chatName: contactId.text,
          messages: [Message(sender: homeState.myId, text: firstMessage.text, senderUserName: homeState.userName!)],
      image: base64Image));
      connection.invoke('sendMessage', args: [int.parse(contactId.text), firstMessage.text, true]);

      homeState.rebuildChatList.toggle();
      //todo remove this rebuild the rebuild in receiveUserName method is enough


  }





}
