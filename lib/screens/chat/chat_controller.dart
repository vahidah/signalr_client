import 'dart:core';
import 'package:messaging_signalr/messaging_signalr.dart';



import '/core/constants/route_names.dart';
import '/core/dependency_injection.dart';
import '/core/interfaces/controller.dart';
import 'chat_state.dart';
import '../home/home_state.dart';





class ChatController extends MainController {
  final ChatState chatState = getIt<ChatState>();
  final HomeState homeState = getIt<HomeState>();
  final SignalRMessaging signalRMessaging = getIt<SignalRMessaging>();
  // final HubConnection connection = getIt<HubConnection>();






  @override
  void onInit() {

    // debugPrint("finding chatKey");
    // chatState.chat = signalRMessaging.chats.firstWhere((element) {
    //   debugPrint("chatkey is : ${chatState.chatKey} and element key is : ${element.chatName}");
    //   return element.chatName == chatState.chatKey!.value;
    // }).obs;
    signalRMessaging.setSelectedChat(chatState.chatKey!.value);
    super.onInit();
  }

  void sendMessage(bool privateChat){
    // if(privateChat) {
    //   chatState.chat!.value.messages.add(
    //       Message(sender: ConstValues.myId, text: chatState.textController.text, senderUserName: ConstValues.userName));
    //   connection.invoke(
    //       'sendMessage', args: [int.parse(chatState.chat!.value.chatName), chatState.textController.text, false]);
    // }else {
    //   connection.invoke('SendMessageToGroup', args: [chatState.chat!.value.chatName, ConstValues.myId, chatState.textController.text]);
    // }
    signalRMessaging.sendMessage(privateChat: privateChat, message: chatState.textController.text);
    chatState.textController.clear();
    chatState.setState();
  }

  void bachToHomeScreen(){
    myNavigator.goToName(RouteNames.home);
  }

  void textControllerChanged(String str){

    if (str == "") {
      chatState.setShowSendMessageIcon = false;
    } else if (str != "") {
      chatState.setShowSendMessageIcon = true;
    }
  }





}
