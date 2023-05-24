
import 'dart:core';
import 'package:get/get.dart';
import 'package:messaging_signalr/messaging_signalr.dart';
import 'package:signalr_core/signalr_core.dart';

import '../chat/chat_state.dart';
import '../sign_up/sign_up_state.dart';
import '/core/constants/route_names.dart';
import '/core/dependency_injection.dart';
import '/core/interfaces/controller.dart';




class SettingsController extends MainController {

  final SignUpState signUpState = getIt<SignUpState>();
  final SignalRMessaging signalRMessaging = getIt<SignalRMessaging>();

  void backToHome() {
    nav.goToName(RouteNames.home);
  }

  void logout() {

    signalRMessaging.logout();
  }


}