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
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'core/dependency_injection.dart';
import 'screens/home/home_state.dart';
import 'screens/chat/chat_state.dart';
import 'screens/create_group/create_group_state.dart';
import 'screens/new_chat/new_chat_state.dart';
import 'screens/new_contact/new_contact_state.dart';
import 'screens/sign_up/sign_up_state.dart';
import 'core/navigation/router.dart';
import 'signalr_fucntions.dart';
import 'core/dependency_injection.dart';
import 'core/classes/chat.dart';
import 'core/classes/message.dart';

final connection = HubConnectionBuilder()
    .withUrl(
    'http://10.0.2.2:5000/Myhub',
    HttpConnectionOptions(
      client: IOClient(HttpClient()..badCertificateCallback = (x, y, z) => true),
      logging: (level, message) => debugPrint(message),
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
  //todo move it to controller

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

    define_signalr_functions();


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
