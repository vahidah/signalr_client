import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signalr_client/core/classes/chat.dart';
import 'package:signalr_client/screens/chat/widgets/message.dart';

// import '/core/constants/constants.dart';
import '/core/dependency_injection.dart';
// import '/widgets/LoadingWidget.dart';
// import '/widgets/my_app_bar.dart';
import 'chat_controller.dart';
// import '../widgets/drawer_widget.dart';
// import '../widgets/home_header.dart';
// import '../widgets/home_list_widget.dart';

class ChatView extends StatelessWidget {
  final ChatController myController = getIt<ChatController>();

  ChatView({required this.chatKey, Key? key}) : super(key: key);

  final String chatKey;

  @override
  Widget build(BuildContext context) {
    debugPrint("before controller init");
    myController.onInit(args: chatKey);
    debugPrint("after controller init");
    return SafeArea(
      child: Stack(
        children: [
          Image.asset(
            "assets/images/chatbackwhatsapp.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                  // bottom: TabBar(
                  //   tabs: tabs,
                  //   controller: tabController,
                  // ),
                  leading: IconButton(
                    onPressed: () {
                      myController.bachToHomeScreen();
                    },
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  title: Text(
                    "My Id is ${myController.homeState.myId}",
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  )),
              body:
                  // myController.homeState.rebuildChatList.value;
                  Stack(
                children: [
                 Obx(() {
                   debugPrint("rebuild this chat");
                   myController.chatState.rebuildChatList.value;
                  return Container(
                    height: MediaQuery.of(context).size.height - 140,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        ...myController.chat!.messages.map((e) {
                          return MessageWidget(
                            messageText:
                                e.text ,
                            clientMessage: e.sender == myController.homeState.myId,
                            chatType: myController.chat!.type,
                            senderId: e.sender,
                            date: e.date!,
                            senderUserName: e.senderUserName,
                          );
                        }).toList()
                      ],
                    ),
                  );}),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Obx( () {
                      myController.chatState.showSendMessageIcon.value;
                      return Row(
                      children: [
                        Container(
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
                                    icon: Icon(Icons.emoji_emotions),
                                    onPressed: () {},
                                  ),
                                  suffixIcon: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.attach_file),
                                        padding: EdgeInsets.zero,
                                      ),
                                      myController.textController.text == "" ?   IconButton(
                                          onPressed: () {
                                            if(myController.textController.text  == ""){
                                              debugPrint("what is this");
                                            }

                                          }, icon: Icon(Icons.camera_alt), padding: EdgeInsets.zero) : SizedBox(height: 0, width: 0,)
                                    ],
                                  ),
                                  contentPadding: EdgeInsets.all(10),
                                  hintText: "Message"),
                              controller: myController.textController,
                              onChanged: (str){
                                //todo move this code to controller
                                if(str ==  ""  && myController.chatState.showSendMessageIcon.value){
                                  myController.chatState.showSendMessageIcon.toggle();
                                }else if(str != "" && !myController.chatState.showSendMessageIcon.value){
                                  myController.chatState.showSendMessageIcon.toggle();
                                }
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2, right: 2, bottom: 8),
                          child: CircleAvatar(
                            radius: 25,
                            child: myController.textController.text == "" ?  IconButton(onPressed: () {}, icon: Icon(Icons.mic)) :
                            IconButton(
                                onPressed: () => myController.chat?.type == ChatType.contact ? myController.sendMessageToContact() :
                                    myController.sendMessageToGroup()
                                , icon: Icon(Icons.send)),
                          ),
                        )
                      ],
                    ); }),
                  )
                ],
              )

              // Obx(() => myController.homeState.homeLoading.value
              //     ? const LoadingWidget()
              //     : SingleChildScrollView(
              //     padding: const EdgeInsets.only(bottom: 100),
              //     child: HomeListWidget(listFlights: myController.showFlightList()))),
              )
        ],
      ),
    );
  }
}
