import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signalr_client/screens/chat/widgets/message.dart';

// import '/core/constants/constants.dart';
import '/core/dependency_injection.dart';
// import '/widgets/LoadingWidget.dart';
// import '/widgets/my_app_bar.dart';
import 'new_chat_controller.dart';
// import '../widgets/drawer_widget.dart';
// import '../widgets/home_header.dart';
// import '../widgets/home_list_widget.dart';

class NewChatView extends StatelessWidget {
  final NewChatController myController = getIt<NewChatController>();

  NewChatView({Key? key}) : super(key: key);



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
                myController.backToHomeScreen();
              },
              icon: Icon(Icons.arrow_back, color: Colors.white),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create new chat",
                  style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            )),
        body: Column(
          children: [
            TextButton(onPressed: () => myController.goToCreateGroupScreen(), child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Icon(Icons.group, color: Colors.black, size: 20,),
                ),
                Text("New group or join Group",  style: TextStyle(color: Colors.black, fontSize: 20),),
              ],
            )),
            TextButton(onPressed: () => myController.goToNewContactScreen(), child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
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
