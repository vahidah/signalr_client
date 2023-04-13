import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messaging_signalr/messaging_signalr.dart';
import 'package:provider/provider.dart';
import 'package:signalr_client/core/constants/ui.dart';

import '../../core/constants/constant_values.dart';
import '../../core/util/Extensions.dart';
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
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ProjectColors.backGroundOrangeType3,
          title: Text("MY ID IS ${signalRMessaging.myId}",
              style: const TextStyle(fontSize: 20, color: ProjectColors.fontBlackColorType1)),
          actions: const [
            // IconButton(
            //     onPressed: () {},
            //     icon: const Icon(
            //       Icons.search,
            //       color: ProjectColors.fontWhite,
            //     )),
            // IconButton(
            //     onPressed: () {},
            //     icon: const Icon(
            //       Icons.more_vert,
            //       color: ProjectColors.fontWhite,
            //     ))
          ],
        ),
        body: signalRMessaging.chats.isEmpty
            ? const Center(child: Text("No Chat Yet!", style: TextStyle(fontSize: 30)))
            : ListView(
                shrinkWrap: true,
                children: [
                  SizedBox(
                    width: 200,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: ProjectColors.backGroundOrangeType2,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: TextField(
                        onTapOutside: (info) {
                          state.searchFocus.unfocus();
                        },
                        onChanged: (str) {
                          state.setState();
                        },
                        focusNode: state.searchFocus,
                        controller: state.searchController,
                        style: const TextStyle(fontSize: 15),
                        decoration: InputDecoration(
                          hintStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          hintText: 'Search',
                          suffixIcon: IconButton(
                              onPressed: () {
                              },
                              icon: const Icon(Icons.search)),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(15),
                        ),
                      ),
                    ),
                  ),
                  ...signalRMessaging.chats.map((e) {
                    return (e.userName?.toLowerCase() ?? e.chatId.toLowerCase())
                            .contains(state.searchController.text.toLowerCase())
                        ? TextButton(
                            onPressed: () => myController.goToChatScreen(e.chatId),
                            child: Container(
                              height: 75,
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1.0, color: ProjectColors.lightBlackHome, style: BorderStyle.solid))),
                              child: Row(
                                children: [
                                  Container(
                                      margin: const EdgeInsets.only(right: 8.0, left: 8.0, bottom: 8.0),
                                      padding: const EdgeInsets.all(10),
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          color: Colors.orangeAccent, borderRadius: BorderRadius.circular(30)
                                          //more than 50% of width makes circle
                                          ),
                                      child: e.image == null
                                          ? FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                e.userName?.showInAvatar() ?? e.chatId.showInAvatar(),
                                                style: const TextStyle(color: ProjectColors.fontWhite),
                                              ),
                                            )
                                          : Image.memory(base64.decode(e.image!))),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 8.0),
                                          child: Text(
                                            e.userName?.capitalizeFirstLetter() ?? e.chatId.capitalizeFirstLetter(),
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: ProjectColors.boldBlackChatTitle),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 8.0),
                                          child: Text(
                                            (chatController.draftMessage.containsKey(e.chatId) &&
                                                    chatController.draftMessage[e.chatId] != "")
                                                ? "draft: ${chatController.draftMessage[e.chatId]}"
                                                : e.messages.isNotEmpty
                                                    ? "${e.type == ChatType.contact ? "" : "${e.messages.last.senderUserName} : "}${myController.firstPartOfChat(e.messages.last.text)}"
                                                    : e.type == ChatType.contact
                                                        ? "say hi to ${e.userName}!"
                                                        : "say hi to all!",
                                            style: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                color: ProjectColors.boldBlackChatTitle),
                                            maxLines: 1,
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
                                            e.messages.isNotEmpty
                                                ? "${e.messages.last.date?.hour}: ${e.messages.last.date?.minute}"
                                                : "",
                                            style: const TextStyle(color: ProjectColors.fontGray),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        : Container();
                  }).toList()
                ],
              ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: ProjectColors.backGroundOrangeType1,
          onPressed: () => myController.goToNewChatScreen(),
          child: const Icon(Icons.chat),
        ),
      ),
    );
  }
}
