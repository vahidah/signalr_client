import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signalr_client/screens/new_chat/new_chat_state.dart';

import '../../core/constants/ui.dart';
import '/core/dependency_injection.dart';
import 'new_chat_controller.dart';

class NewChatView extends StatelessWidget {
  final NewChatController myController = getIt<NewChatController>();

  NewChatView({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    NewChatState state = context.watch<NewChatState>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                myController.backToHomeScreen();
              },
              icon: const Icon(Icons.arrow_back, color: ProjectColors.fontWhite),
            ),
            title: const Text(
              "Create new chat",
              style: TextStyle(fontSize: ProjectSizes.newChatText, color: ProjectColors.fontWhite, fontWeight: FontWeight.bold),
            )),
        body: Column(
          children: [
            TextButton(onPressed: () => myController.goToCreateGroupScreen(), child: Row(
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Icon(Icons.group, color: ProjectColors.iconBlackColor, size: ProjectSizes.newChatIcon,),
                ),
                Text("New group or join Group",  style: TextStyle(color: ProjectColors.fontBlackHome, fontSize: ProjectSizes.newChatText),),
              ],
            )),
            TextButton(onPressed: () => myController.goToNewContactScreen(), child: Row(
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Icon(Icons.add_reaction, color: ProjectColors.lightBlackHome, size: ProjectSizes.newChatIcon,),
                ),
                Text("New contact", style: TextStyle(color: ProjectColors.fontBlackHome, fontSize: ProjectSizes.newChatText),)
              ],
            ))
          ],
        ),
      ),
    );
  }
}
