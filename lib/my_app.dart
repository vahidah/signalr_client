import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signalr_client/core/constants/constant_values.dart';
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
        textTheme: GoogleFonts.alegreyaTextTheme()
      ),
      // routeInformationParser:  MyRouter.router.routeInformationParser,
      // routerDelegate: MyRouter.router.routerDelegate,
      routerConfig:  MyRouter.router,
    );
  }
}

