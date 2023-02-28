import 'dart:async';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'my_app.dart';
import 'core/dependency_injection.dart';
import 'screens/home/home_state.dart';
import 'screens/chat/chat_state.dart';
import 'screens/create_group/create_group_state.dart';
import 'screens/new_chat/new_chat_state.dart';
import 'screens/add_contact/new_contact_state.dart';
import 'screens/sign_up/sign_up_state.dart';





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
