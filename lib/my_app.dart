import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:signalr_core/signalr_core.dart';
import 'dart:core';

import 'core/navigation/router.dart';
import 'core/constants/strings.dart';
import 'core/dependency_injection.dart';
import 'signalr_functions.dart';


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

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{

  bool tokenSend = false;
  // final connection = getIt<HubConnection>();


  // void _initializeSignalRConnection() async {
  //   await connection.start();
  // }

  final FirebaseMessaging _firebasemessaging = FirebaseMessaging.instance;

  _getToken() {
    _firebasemessaging.getToken().then((deviceToken) {
      debugPrint("Device Token: $deviceToken");
      ConstStrings.fireBaseToken = deviceToken?? "";
    });
  }



  @override
  initState() {
    // TODO: implement initState
    super.initState();

    // _initializeSignalRConnection();

    // _getToken();

    // define_signalr_functions();


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
