import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:signalr_client/core/classes/chat.dart';
import 'package:signalr_client/screens/chat/widgets/message.dart';

import '../../core/constants/constant_values.dart';
import '/core/constants/ui.dart';
import '/core/dependency_injection.dart';
import 'chat_controller.dart';
import 'chat_state.dart';

class ChatView extends StatelessWidget {
  final ChatController myController = getIt<ChatController>();

  ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChatState state = context.watch<ChatState>();
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  myController.bachToHomeScreen();
                },
                icon: const Icon(Icons.arrow_back, color: ProjectColors.fontWhite),
              ),
              title: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: MemoryImage(base64.decode(state.chat!.value.image!)),
                  ),
                  Text(
                    "My Id is ${ConstValues.myId}",
                    style: const TextStyle(fontSize: 20, color: ProjectColors.fontWhite),
                  ),
                ],
              )),
          body:
              // myController.homeState.rebuildChatList.value;
              Stack(
            children: [
              Image.asset(
                "assets/images/chatbackwhatsapp.png",
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              Obx(() {
                debugPrint("rebuild this chat");
                return SizedBox(
                  height: MediaQuery.of(context).size.height - 140,
                  child: ListView(
                    shrinkWrap: true,
                    children: state.chat!.value.messages.map((e) {
                      return MessageWidget(
                        clientMessage: e.sender == ConstValues.myId,
                        chatType: state.chat!.value.type,
                        message: e,
                      );
                    }).toList(),
                  ),
                );
              }),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 55,
                        child: Card(
                          margin: const EdgeInsets.only(left: 2, right: 2, bottom: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
                            minLines: 1,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: IconButton(
                                  icon: const Icon(Icons.emoji_emotions),
                                  onPressed: () {},
                                ),
                                suffixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.attach_file),
                                      padding: EdgeInsets.zero,
                                    ),
                                    state.textController.text == ""
                                        ? IconButton(
                                            onPressed: () {
                                              if (state.textController.text == "") {
                                                debugPrint("what is this");
                                              }
                                            },
                                            icon: const Icon(Icons.camera_alt),
                                            padding: EdgeInsets.zero)
                                        : const SizedBox(
                                            height: 0,
                                            width: 0,
                                          )
                                  ],
                                ),
                                contentPadding: const EdgeInsets.all(10),
                                hintText: "Message"),
                            controller: state.textController,
                            onChanged: (str) => myController.textControllerChanged(str),
                          ),
                        ),
                      ),
                          Padding(
                        padding: const EdgeInsets.only(left: 2, right: 2, bottom: 8),
                        child: CircleAvatar(
                          radius: 25,
                          child: state.textController.text == ""
                              ? IconButton(onPressed: () {}, icon: const Icon(Icons.mic))
                              : IconButton(
                                  onPressed: () => myController.sendMessage(state.chat!.value.type == ChatType.contact),
                                  icon: const Icon(Icons.send)),
                        ),
                      )
                    ],
                  ),
              )
            ],
          )),
    );
  }
}
