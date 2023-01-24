import 'package:flutter/material.dart';
import 'dart:core';

import 'core/navigation/router.dart';



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser:  MyRouter.router.routeInformationParser,
      routerDelegate: MyRouter.router.routerDelegate,
    );
  }
}

