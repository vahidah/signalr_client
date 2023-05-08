



import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:messaging_signalr/messaging_signalr.dart';
import 'package:signalr_client/core/util/Extensions.dart';
import 'package:signalr_client/screens/home/home_state.dart';

import '../../../core/constants/ui.dart';
import '../../../core/dependency_injection.dart';
import '../../chat/chat_controller.dart';
import '../home_controller.dart';

class ChatsList extends StatelessWidget {
  ChatsList({Key? key, required this.searchedList}) : super(key: key);

  final HomeController myController = getIt<HomeController>();
  final ChatController chatController = getIt<ChatController>();
  final SignalRMessaging signalRMessaging = getIt<SignalRMessaging>();
  final HomeState state = getIt<HomeState >();


  final bool searchedList;


  @override
  Widget build(BuildContext context) {

    return ListView(
      children: [
        ...signalRMessaging.chats.map((e) {
          return (e.name.toLowerCase() )
              .contains(state.searchController.text.toLowerCase()) || !searchedList
              ? Column(
                children: [
                  TextButton(
            onPressed: () => myController.goToChatScreen(e.chatId),
            child: SizedBox(
                  height: 60,
                  child: Row(
                    children: [
                      Container(
                          margin: const EdgeInsets.only(right: 8.0, left: 8.0),
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              color: Colors.orangeAccent, borderRadius: BorderRadius.circular(30),
                            //more than 50% of width makes circle
                          ),
                          child: e.image == null
                              ? Padding(
                            padding: const EdgeInsets.all(10),
                                child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              e.name.showInAvatar(),
                                style: const TextStyle(color: ProjectColors.fontWhite),
                            ),
                          ),
                              )
                              :
                              CircleAvatar(
                                backgroundImage: FileImage(e.image!),
                                radius: 30,
                              ),
                            // FittedBox(
                            // fit: BoxFit.cover,
                            // child: Image.memory(base64.decode(e.image!)),
                          ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Text(
                                e.name.capitalizeFirstLetter() ?? e.chatId.capitalizeFirstLetter(),
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: ProjectColors.boldBlackChatTitle),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(),
                              child: Text(
                                (chatController.draftMessage.containsKey(e.chatId) &&
                                    chatController.draftMessage[e.chatId] != "")
                                    ? "draft: ${chatController.draftMessage[e.chatId]}"
                                    : e.messages.isNotEmpty
                                    ? "${e.type == ChatType.contact ? "" : "${e.messages.last.senderUserName} : "}${myController.firstPartOfChat(e.messages.last.message)}"
                                    : e.type == ChatType.contact
                                    ? "say hi to ${e.name}!"
                                    : "say hi to all!",
                                style: const TextStyle(
                                    fontSize: 17,
                                    color: ProjectColors.fontGray),
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
                                    ? DateFormat.Hm().format(e.messages.last.date!)
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
          ),
                  const Divider(
                    indent: 70,
                    color: ProjectColors.fontGray,
                  )
                ],
              )
              : Container();
        }).toList()
      ],
    );
  }
}
