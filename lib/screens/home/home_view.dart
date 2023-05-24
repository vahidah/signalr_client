import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:messaging_signalr/messaging_signalr.dart';
import 'package:provider/provider.dart';
import 'package:signalr_client/core/constants/ui.dart';
import 'package:signalr_client/screens/home/widgets/ChatsList.dart';

import '../../core/util/Extensions.dart';
import '../../widgets/back_button.dart';
import '../chat/chat_controller.dart';
import '/core/dependency_injection.dart';
import 'home_controller.dart';
import 'home_state.dart';

class HomeView extends StatelessWidget {
  final HomeController myController = getIt<HomeController>();
  final ChatController chatController = getIt<ChatController>();
  final SignalRMessaging signalRMessaging = getIt<SignalRMessaging>();
  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //seems that state didn't used but we pass its set state to package to whenever we received new message rebuild this page
    HomeState state = context.watch<HomeState>();
    debugPrint('in home view builder 2');
    return SafeArea(
      child: IndexedStack(index: state.stackIndex, children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: ProjectColors.backGroundOrangeType3,
            actions: [
              IconButton(
                  onPressed: () {
                    state.setStackIndex = 1;
                  },
                  icon: const Icon(
                    Icons.search,
                    color: ProjectColors.fontWhite,
                  )),
              // IconButton(
              //     onPressed: () {},
              //     icon: const Icon(
              //       Icons.more_vert,
              //       color: ProjectColors.fontWhite,
              //     ))
            ],
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text('Its Empty Already'),
                ),
                ListTile(
                  title: TextButton(
                    onPressed: () => myController.goToSettingsScreen(),
                    child: Row(
                      children: [
                        Icon(Icons.settings, size: 30,),
                        SizedBox(width: 30,),
                        Text("Settings", style: TextStyle(fontSize: 20),)
                      ],
                    ),
                  ),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
          body: signalRMessaging.chats.isEmpty
              ? const Center(child: Text("No Chat Yet!", style: TextStyle(fontSize: 30)))
              : ChatsList(searchedList: false),
          floatingActionButton: FloatingActionButton(
            backgroundColor: ProjectColors.backGroundOrangeType1,
            onPressed: () => myController.goToNewChatScreen(),
            child: const Icon(Icons.chat),
          ),
        ),
        Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5.0, top: 8.0),
                child: Row(
                  children: [
                    BackButtonLocal(
                      onTap: () {
                        state.setStackIndex = 0;
                      },
                      color: ProjectColors.fontBlackColorType3,
                      size: 25,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 5.0),
                      width: 330,
                      child: TextField(
                        onChanged: (String str) {
                          debugPrint("text field value changed");
                          state.setState();

                          if(str == ""){
                            state.isSearchEmpty = true;
                          }else{
                            state.isSearchEmpty = false;
                          }

                        },
                        controller: state.searchController,
                        style: const TextStyle(fontSize: 20, color: ProjectColors.fontBlackColorType1),
                        decoration: InputDecoration(
                            suffixIcon: !state.isSearchEmpty ?
                                IconButton(
                                    onPressed: () {
                                      state.searchController.clear();
                                      state.setState();
                                    },
                                    icon: const Icon(Icons.close, color: ProjectColors.fontBlackColorType3, size: 23),
                                  )
                                : const SizedBox(
                                    width: 0,
                                    height: 0,
                                  ),
                            border: InputBorder.none,
                            hintText: 'Search',
                            hintStyle: const TextStyle(fontSize: 20)),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(child: ChatsList(searchedList: true,))
            ],
          ),
        )
      ]),
    );
  }
}
