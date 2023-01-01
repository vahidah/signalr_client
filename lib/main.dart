import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:provider/provider.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/dependency_injection.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'screens/home/home_state.dart';
import 'screens/chat/chat_state.dart';
import 'screens/create_group/create_group_state.dart';
import 'screens/new_chat/new_chat_state.dart';
import 'screens/new_contact/new_contact_state.dart';
import 'screens/sign_up/sign_up_state.dart';
import 'core/navigation/router.dart';
import 'core/dependency_injection.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'core/classes/chat.dart';
import 'core/classes/message.dart';

final connection = HubConnectionBuilder()
    .withUrl(
    'http://10.0.2.2:5000/Myhub',
    HttpConnectionOptions(
      client: IOClient(HttpClient()..badCertificateCallback = (x, y, z) => true),
      logging: (level, message) => print(message),
    ))
    .build();


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await init();
  runZonedGuarded(
      () => runApp(
            MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) => getIt<HomeState>()),
                ChangeNotifierProvider(create: (_) => getIt<CreateGroupState>()),
                ChangeNotifierProvider(create: (_) => getIt<ChatState>()),
                ChangeNotifierProvider(create: (_) => getIt<NewChatState>()),
                ChangeNotifierProvider(create: (_) => getIt<NewContactState>()),
                ChangeNotifierProvider(create: (_) => getIt<SignUpState>()),
              ],
              child: const MyApp(),
            ),
          ), (error, stack) {
    debugPrint("we have error");
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "simple chat app",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  final myHomeState = getIt<HomeState>();
  final myChatState = getIt<ChatState>();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {



  bool tokenSend = false;




  void _initializeSignalRConnection() async {
    await connection.start();
  }

  final FirebaseMessaging _firebasemessaging = FirebaseMessaging.instance;

  _getToken() {
    print('here1');
    _firebasemessaging.getToken().then((deviceToken) {
      print("Device Token: $deviceToken");
      widget.myHomeState.firebaseToken = deviceToken;
    });
  }



  @override
  initState() {
    // TODO: implement initState
    super.initState();

    _initializeSignalRConnection();

    _getToken();

    connection.on('ReceiveNewMessage', (message) async{
      debugPrint("new message received");
      int targetIndex = widget.myHomeState.chats.indexWhere((e) => e.chatName == message![0].toString());
      if(targetIndex != -1){
        widget.myHomeState.chats[targetIndex].messages.add( Message(sender: message![0], text: message[1], senderUserName: message[2]));
        widget.myHomeState.chats.insert(0, widget.myHomeState.chats[targetIndex]);
        widget.myHomeState.chats.removeAt(targetIndex + 1);
        widget.myChatState.rebuildChatList.toggle();
        widget.myHomeState.rebuildChatList.toggle();
      }else{
        debugPrint("send request to get image");
        Map<String, String> requestHeaders = {
          "Connection": "keep-alive",
        };
        http.Response response = await http.post(
            Uri.parse("http://10.0.2.2:9000/api/Image/${message![0]}",),
            headers: requestHeaders

        );
        debugPrint("image received");
        final base64Image = base64.encode(response.bodyBytes);
        widget.myHomeState.chats.insert(0, Chat(type: ChatType.contact, chatName: message[0].toString(), messages:
          [Message(sender: message[0], text: message[1], senderUserName: message[2],)],userName: message[2],
        image:  base64Image),);
        widget.myHomeState.rebuildChatList.toggle();
      }

      debugPrint("new message received from ${message[0]}");
      debugPrint(message[1]);
    });
    connection.on('receiveUserName', (message){
      int targetChat = widget.myHomeState.chats.indexWhere((element) => element.chatName == message![0].toString());
      widget.myHomeState.chats[targetChat].userName = message![1];
      debugPrint("receive user name");
      widget.myHomeState.userNameReceived.toggle();
      debugPrint("value is: ${widget.myHomeState.userNameReceived.toggle()}");
      widget.myHomeState.rebuildChatList.toggle();
    });

    connection.on('GroupMessage', (message) {
      debugPrint("new message for group ${message![0]} form user ${message[1]} received, message is ${message[2]}");
      debugPrint(message[1].toString());
      int targetIndex = widget.myHomeState.chats.indexWhere((e) => e.chatName == message[0]);
      if(targetIndex != -1){
        widget.myHomeState.chats[targetIndex].messages.add(Message(sender: message[1], text: message[2], senderUserName: message[3]));
        widget.myHomeState.chats.insert(0, widget.myHomeState.chats[targetIndex]);
        widget.myHomeState.chats.removeAt(targetIndex + 1);
        widget.myChatState.rebuildChatList.toggle();
        widget.myHomeState.rebuildChatList.toggle();
      }else{
        debugPrint("here1");
        widget.myHomeState.chats.insert(0, Chat(type: ChatType.contact, chatName: message[0].toString(), messages:
        [Message(sender: message[1], text: message[2], senderUserName: message[3]),]));
        widget.myHomeState.rebuildChatList.toggle();
      }

    });

    connection.on('ReceiveId', (message) {
      widget.myHomeState.myId = message![0];
      debugPrint("client id is ${widget.myHomeState.myId}");
      connection.invoke('ReceiveFireBaseToken', args: [widget.myHomeState.firebaseToken]);
      debugPrint("connection status:  ${connection.state}");
      debugPrint("sending token");
      widget.myHomeState.idReceived.toggle();
    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser:  MyRouter.router.routeInformationParser,
      routerDelegate: MyRouter.router.routerDelegate,
    );
  }
}
