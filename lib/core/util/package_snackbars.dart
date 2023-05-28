

import 'package:flutter/material.dart';
import 'package:signalr_client/core/constants/ui.dart';
import 'package:signalr_client/widgets/ProjectTextField.dart';

import '../dependency_injection.dart';
import '../navigation/navigation_service.dart';

class PackageHintSnackBar{
  static final NavigationService navigationService = getIt<NavigationService>();


  static void showSnackBar(String message, bool warning){
    navigationService.snackBar(
      Text(message, style: const TextStyle(fontSize: 20),),
      icon: warning ? Icons.warning : Icons.info,
      backgroundColor: warning ? ProjectColors.snackBarError : ProjectColors.snackBarInfo,
      duration: const Duration(seconds: 8),
    );

  }
}

// class PackageFailureSnackBar{
//   static final NavigationService navigationService = getIt<NavigationService>();
//
//
//   static void showSnackBar(String message, Function retry){
//     navigationService.snackBar(
//         Text(message),
//         icon: Icons.error,
//         backgroundColor: Colors.red,
//         duration: const Duration(seconds: 20),
//         action: SnackBarAction(
//           textColor: Colors.white,
//           label: "Retry",
//           onPressed: () => retry,
//         )
//     );
//
//   }
// }