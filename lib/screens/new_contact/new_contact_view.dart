import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:signalr_client/screens/new_contact/new_contact_state.dart';


import '../../widgets/ProjectTextField.dart';
import '/core/dependency_injection.dart';
import '/core/constants/ui.dart';
import 'new_contact_controller.dart';


class NewContactView extends StatelessWidget {
  final NewContactController myController = getIt<NewContactController>();

  NewContactView({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    NewContactState state = context.watch<NewContactState>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                myController.backToNewChatScreen();
              },
              icon: const Icon(Icons.arrow_back, color: ProjectColors.fontWhite),
            ),
            title: const Text(
              "Create new contact",
              style: TextStyle(fontSize: 20, color: ProjectColors.fontWhite, fontWeight: FontWeight.bold),
            )),
        body: Obx( () => state.userNameReceived.value ? Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: ProjectTextField(
                style: const TextStyle(
                    decoration: TextDecoration.none, color: ProjectColors.fontBlackHome, fontWeight: FontWeight.bold),
                controller: state.contactId,
                hintText: "Enter contact Id",
              )),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: ProjectTextField(
                style: const TextStyle(
                    decoration: TextDecoration.none, color: ProjectColors.fontBlackHome, fontWeight: FontWeight.bold),
                hintText: "Enter first message",
                controller: state.firstMessage,
              )
            ),
          ],
        ) : const Center(child: CircularProgressIndicator(),)),
        floatingActionButton: FloatingActionButton(
          onPressed: () => myController.sendFirstMessage(),
          child: const Icon(Icons.done),
        ),
      ),
    );
  }
}
