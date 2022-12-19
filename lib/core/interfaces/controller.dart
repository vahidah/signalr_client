import 'dart:developer';

// import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';

import '/core/dependency_injection.dart';
// import '../data_base/share_pref.dart';
import '../navigation/navigation_service.dart';
import '../navigation/router.dart';
// import '../util/app_config.dart';
// import '../util/theme_service.dart';

abstract class MainController {
  late NavigationService myNavigator;
  // late SharedPrefService prefs;
  // late ThemeService themeService;
  final MyRouter router = MyRouter();
  bool initialized = false;

  MainController() {
    myNavigator = getIt<NavigationService>();
    // prefs = getIt<SharedPrefService>();
    // themeService = getIt<ThemeService>();

    if (!initialized) {
      onCreate();
    }
  }

  void onInit({dynamic args}) {
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
