import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:signalr_client/screens/add_contact/new_contact_state.dart';

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
            backgroundColor: ProjectColors.backGroundOrangeType3,
            leading: IconButton(
              onPressed: () {
                myController.backToNewChatScreen();
              },
              icon: const Icon(Icons.arrow_back, color: ProjectColors.fontWhite),
            ),
            title: const Text(
              "Create new contact",
              style:
                      TextStyle(fontSize: 20, color: ProjectColors.fontWhite, fontWeight: FontWeight.bold),
            )),
        body: Obx(() => state.getContactInfoCompleted.value
            ? Column(
                children: [
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: TextField(
                          style: const TextStyle(
                              decoration: TextDecoration.none,
                              color: ProjectColors.fontBlackColorType1,
                              fontWeight: FontWeight.bold),
                          controller: state.contactPhoneController,
                          decoration: InputDecoration(
                              hintText: "Enter contact phone number",
                              errorMaxLines: 3,
                              errorStyle: TextStyle(fontSize: 15),
                              errorText:
                                  state.correctPhoneNumber.value ? null : "Please enter correct phone number"
                                      "(it sould be numeric and it's length should be longer than 9 and less than 13)"))),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              )),
        floatingActionButton: FloatingActionButton(
          backgroundColor: ProjectColors.backGroundOrangeType1,
          onPressed: () => myController.addNewContact(),
          child: const Icon(Icons.done),
        ),
      ),
    );
  }
}
