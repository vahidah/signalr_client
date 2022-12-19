import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signalr_client/screens/chat/widgets/message.dart';

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
    myController.onInit();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // bottom: TabBar(
          //   tabs: tabs,
          //   controller: tabController,
          // ),
            leading: IconButton(
              onPressed: () {
                myController.backToNewChatScreen();
              },
              icon: Icon(Icons.arrow_back, color: Colors.white),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create new contact",
                  style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            )),
        body: Obx( () => myController.homeState.userNameReceived.value ? Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Enter contact Id"
                ),
                controller: myController.contactId,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: "Enter first message"
                ),
                controller: myController.firstMessage,
              ),
            ),
          ],
        ) : Center(child: CircularProgressIndicator(),)),
        floatingActionButton: FloatingActionButton(
          onPressed: () => myController.sendFirstMessage(),
          child: Icon(Icons.done),
        ),
      ),
    );
  }
}
