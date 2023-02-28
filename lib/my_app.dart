import 'package:flutter/material.dart';
import 'package:signalr_client/core/constants/ui.dart';
import 'dart:core';

import 'core/navigation/router.dart';



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        colorScheme: ThemeData().colorScheme.copyWith(),
      ),
      // routeInformationParser:  MyRouter.router.routeInformationParser,
      // routerDelegate: MyRouter.router.routerDelegate,
      routerConfig: MyRouter.router,
    );
  }
}

