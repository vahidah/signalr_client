import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signalr_client/screens/chat/widgets/message.dart';

import '/core/dependency_injection.dart';
import 'new_chat_controller.dart';

class NewChatView extends StatelessWidget {
  final NewChatController myController = getIt<NewChatController>();

  NewChatView({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                myController.backToHomeScreen();
              },
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Create new chat",
                  style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            )),
        body: Column(
          children: [
            TextButton(onPressed: () => myController.goToCreateGroupScreen(), child: Row(
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Icon(Icons.group, color: Colors.black, size: 20,),
                ),
                Text("New group or join Group",  style: TextStyle(color: Colors.black, fontSize: 20),),
              ],
            )),
            TextButton(onPressed: () => myController.goToNewContactScreen(), child: Row(
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Icon(Icons.add_reaction, color: Colors.black, size: 20,),
                ),
                Text("New contact", style: TextStyle(color: Colors.black, fontSize: 20),)
              ],
            ))
          ],
        ),
      ),
    );
  }
}
