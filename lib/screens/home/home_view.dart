import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signalr_client/core/classes/chat.dart';
import 'package:signalr_client/screens/chat/widgets/message.dart';

// import '/core/constants/constants.dart';
import '/core/dependency_injection.dart';
// import '/widgets/LoadingWidget.dart';
// import '/widgets/my_app_bar.dart';
import 'home_controller.dart';
// import '../widgets/drawer_widget.dart';
// import '../widgets/home_header.dart';
// import '../widgets/home_list_widget.dart';

class HomeView extends StatelessWidget {
  final HomeController myController = getIt<HomeController>();

  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int imageIndex = -1;
    return SafeArea(
        child: Scaffold(

      appBar: AppBar(
        // bottom: TabBar(
        //   tabs: tabs,
        //   controller: tabController,
        // ),
        //   leading: IconButton(
        //     onPressed: () {
        //       myController.bachToHomeScreen();
        //     },
        //     icon: Icon(Icons.arrow_back, color: Colors.white),
        //   ),
        title: Text(
          "My Id is ${myController.homeState.myId}",
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ))
        ],
      ),
      body:

          Obx(() {
        debugPrint("rebuild this chat");
        imageIndex = 0;
        myController.homeState.rebuildChatList.value;
        return ListView(
          shrinkWrap: true,
          children: [
            ...myController.homeState.chats.map((e) {
              debugPrint("user name is : ${e.userName}");
              imageIndex++;
              return TextButton(
                onPressed: () => myController.goToChatScreen(e.chatName),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(
                      width: 1.0,
                      color: Colors.black54,
                      style: BorderStyle.solid
                    ))
                  ),
                  child: Row(

                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: CircleAvatar(
                          backgroundImage: AssetImage("assets/images/$imageIndex.jpg"),
                          radius: 25,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(e.userName?? e.chatName, style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: Colors.black),),
                            ),
                            Text(e.messages.isNotEmpty ? "${e.messages[0].senderUserName} : ${e.messages[0].text}" : "",
                              style: TextStyle(color: Colors.black54,),
                            ),

                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: const Text(
                                "19:54",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }).toList()
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => myController.goToNewChatScreen(),
        child: const Icon(Icons.chat),
      ),

    ),

    );
  }
}
