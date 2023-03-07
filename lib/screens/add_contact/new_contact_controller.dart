
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dartz/dartz.dart';
import 'package:messaging_signalr/messaging_signalr.dart';
import 'package:signalr_client/screens/add_contact/new_contact_repositroy.dart';
import 'package:signalr_client/screens/add_contact/usecases/get_image_usecase.dart';
import 'package:signalr_core/signalr_core.dart';

import '../../core/navigation/navigation_service.dart';
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
    // TODO: implement onInit
    newContactState.contactIdController.clear();
    super.onInit();
  }


  void backToNewChatScreen() {
    myNavigator.goToName(RouteNames.newChat);
  }

  // Future<String> getImage()async{
  //   GetImageRequest imageRequest = GetImageRequest(contactId: int.parse(newContactState.contactId.text));
  //   final result = await getImageUseCase(request: imageRequest);
  //   if(result.isRight()){
  //     return (result as Right).value;
  //   }else{
  //     FailureHandler.handle((result as Left).value, retry: () => getImage());
  //     return "";
  //   }
  //   //result.fold((failure) => FailureHandler.handle(failure, retry: () => getImage()), (r) => {base64Image = r});
  // }

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
    // debugPrint("newContactController 1");
    // String? base64Image = await getImage();
    // debugPrint("newContactController 2");
    // if(base64Image != "") {
    //   homeState.chats.insert(
    //       0,
    //       Chat(
    //           type: ChatType.contact,
    //           chatName: newContactState.contactId.text,
    //           messages: [
    //             Message(
    //                 sender: ConstValues.myId,
    //                 text: newContactState.firstMessage.text,
    //                 senderUserName: ConstValues.userName)
    //           ],
    //           image: base64Image));
    //   connection.invoke('sendMessage',
    //       args: [int.parse(newContactState.contactId.text), newContactState.firstMessage.text, true]);
    debugPrint("sending First Message to contact");
    newContactState.getContactInfoCompleted.toggle();

    await signalRMessaging.addNewContact(contactId: int.parse(newContactState.contactIdController.text));

    newContactState.contactIdController.clear();

    }

}
