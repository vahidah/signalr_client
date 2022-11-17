import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '/screens/chat/chat_state.dart';







final getIt = GetIt.instance;


Future<void> init() async{





  // chat ------------------------------------------------------------------------------------------------------------------
  ///state
   ChatState chatState = ChatState();
   getIt.registerLazySingleton(() => chatState);

}