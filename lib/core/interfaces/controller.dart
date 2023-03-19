import 'dart:developer';


import 'package:flutter/material.dart';

import '../database/share_pref.dart';
import '/core/dependency_injection.dart';
import '../navigation/navigation_service.dart';
import '../navigation/router.dart';


abstract class MainController {
  late NavigationService nav;
  late SharedPrefService prefs;
  final MyRouter router = MyRouter();
  MainController() {
    nav = getIt<NavigationService>();
    prefs = getIt<SharedPrefService>();
    if(!initialized) {
      onCreate();
    }
  }
  bool initialized = false;


  void onInit() {
    log('$runtimeType Init');
  }

  void onCreate() {
    log('$runtimeType Create');
    initialized = true;
  }

  // changeTheme(BuildContext context) {
  //   log('${ThemeSwitcher.of(context)} ThemeSwitcher');
  //   if (Theme.of(context).brightness == Brightness.light) {
  //     ThemeSwitcher.of(context).changeTheme(theme: AppConfig.themeDark!);
  //   } else {
  //     ThemeSwitcher.of(context).changeTheme(theme: AppConfig.themeLight!);
  //   }
  // }
}
