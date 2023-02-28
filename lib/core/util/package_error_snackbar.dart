

import 'package:flutter/material.dart';
import 'package:signalr_client/core/constants/ui.dart';

import '../dependency_injection.dart';
import '../navigation/navigation_service.dart';

class PackageErrorSnackBar{
  static final NavigationService navigationService = getIt<NavigationService>();


  static void showSnackBar(String message, bool warning){
    navigationService.snackBar(
      Text(message, style: const TextStyle(fontSize: 20),),
      icon: warning ? Icons.warning : Icons.info,
      backgroundColor: warning ? ProjectColors.snackBarError : Colors.cyan,
      duration: const Duration(seconds: 8),
    );

  }
}