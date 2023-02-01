import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:messaging_signalr/messaging_signalr.dart';
import 'package:provider/provider.dart';
import 'package:signalr_client/core/constants/ui.dart';

import '../../core/constants/constant_values.dart';
import '/core/dependency_injection.dart';
import 'home_controller.dart';
import 'home_state.dart';

class HomeView extends StatelessWidget {
  final HomeController myController = getIt<HomeController>();
  final SignalRMessaging signalRMessaging = getIt<SignalRMessaging>();
  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('in home view builder 1');
    HomeState state = context.watch<HomeState>();
    debugPrint('in home view builder 2');
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(

            "My Id is ${signalRMessaging.myId}",
            style: const TextStyle(fontSize: 20, color: ProjectColors.fontWhite),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: ProjectColors.fontWhite,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert,
                  color: ProjectColors.fontWhite,
                ))
          ],
        ),
        body: ListView(
              shrinkWrap: true,
              children: [
                ...signalRMessaging.chats.map((e) {
                  return TextButton(
                    onPressed: () => myController.goToChatScreen(e.chatId),
                    child: Container(
                      height: 60,
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 1.0, color: ProjectColors.lightBlackHome, style: BorderStyle.solid))),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: CircleAvatar(
                              backgroundImage: e.image != null
                                  ? MemoryImage(base64.decode(e.image!))
                                  : const AssetImage("assets/images/4.jpg") as ImageProvider,
                              radius: 25,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    e.userName ?? e.chatId,
                                    style: const TextStyle(
                                        fontSize: 27, fontWeight: FontWeight.bold, color: ProjectColors.lightBlackHome),
                                  ),
                                ),
                                Text(
                                  e.messages.isNotEmpty
                                      ? "${e.messages[0].senderUserName} : ${e.messages[0].text}"
                                      : "",
                                  style: const TextStyle(
                                    color: ProjectColors.lightBlackHome,
                                  ),
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
                                  child: Text(
                                    e.messages.isNotEmpty?
                                    "${e.messages[0].date?.hour}: ${e.messages[0].date?.minute}"
                                    : "",
                                    style: const TextStyle(color: ProjectColors.fontGrayHome),
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
            ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => myController.goToNewChatScreen(),
          child: const Icon(Icons.chat),
        ),
      ),
    );
  }
}
