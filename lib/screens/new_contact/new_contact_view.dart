import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:signalr_client/screens/chat/widgets/message.dart';
import 'package:signalr_client/screens/new_contact/new_contact_state.dart';

// import '/core/constants/constants.dart';
import '/core/dependency_injection.dart';
// import '/widgets/LoadingWidget.dart';
// import '/widgets/my_app_bar.dart';
import 'new_contact_controller.dart';
// import '../widgets/drawer_widget.dart';
// import '../widgets/home_header.dart';
// import '../widgets/home_list_widget.dart';

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
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Create new contact",
                  style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            )),
        body: Obx( () => myController.homeState.userNameReceived.value ? Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: "Enter contact Id"
                ),
                controller: state.contactId,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                decoration: const InputDecoration(
                    hintText: "Enter first message"
                ),
                controller: state.firstMessage,
              ),
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
