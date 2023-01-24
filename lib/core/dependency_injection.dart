import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:signalr_client/screens/new_contact/data_sources/new_contact_local_ds.dart';
import 'package:signalr_client/screens/sign_up/data_sources/signup_local_ds.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/home/home_state.dart';
import '../screens/home/home_controller.dart';
import '../screens/chat/chat_state.dart';
import '../screens/chat/chat_controller.dart';
import '../screens/create_group/create_group_state.dart';
import '../screens/create_group/create_group_controller.dart';
import '../screens/new_chat/new_chat_state.dart';
import '../screens/new_chat/new_chat_controller.dart';
import '../screens/new_contact/new_contact_state.dart';
import '../screens/new_contact/new_contact_controller.dart';
import '../screens/sign_up/sign_up_state.dart';
import '../screens/sign_up/sign_up_controller.dart';
import '../screens/sign_up/data_sources/signup_remote_ds.dart';
import '../screens/sign_up/sign_up_repository.dart';
import '../signalr_functions.dart';
import 'constants/strings.dart';
import 'database/share_pref.dart';
import 'navigation/router.dart';
import '../core/navigation/navigation_service.dart';
import 'constants/route_names.dart';
import '../../core/platform/network_info.dart';
import 'package:signalr_client/screens/new_contact/data_sources/new_contact_remote_ds.dart';
import 'package:signalr_client/screens/new_contact/new_contact_repositroy.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  final connection = HubConnectionBuilder()
      .withUrl(
          'http://10.0.2.2:5000/Myhub',
          HttpConnectionOptions(
            client: IOClient(HttpClient()..badCertificateCallback = (x, y, z) => true),
            logging: (level, message) => debugPrint(message),
          ))
      .build();
  getIt.registerLazySingleton(() => connection);

  SharedPreferences sp = await SharedPreferences.getInstance();

  SharedPrefService sharedPrefService = SharedPrefService(sp);

  NavigationService navigationService = NavigationService();
  getIt.registerSingleton(navigationService);

  Connectivity connectivity = Connectivity();
  NetworkInfo networkInfo = NetworkInfo(connectivity);

  debugPrint("here0");

  // home ------------------------------------------------------------------------------------------------------------------
  ///state
  HomeState homeState = HomeState();
  getIt.registerLazySingleton(() => homeState);

  ///controller
  HomeController homePageController = HomeController();
  getIt.registerLazySingleton(() => homePageController);
  navigationService.registerController(RouteNames.home, homePageController);

  // chat ------------------------------------------------------------------------------------------------------------------
  ChatState chatState = ChatState();
  getIt.registerLazySingleton(() => chatState);

  ///controller
  ChatController chatPageController = ChatController();
  getIt.registerLazySingleton(() => chatPageController);
  // navigationService.registerController(RouteNames.chat, chatPageController);

  // create Group ------------------------------------------------------------------------------------------------------------------
  CreateGroupState createGroupState = CreateGroupState();
  getIt.registerLazySingleton(() => createGroupState);

  CreateGroupController createGroupPageController = CreateGroupController();
  getIt.registerLazySingleton(() => createGroupPageController);
  navigationService.registerController(RouteNames.createGroup, createGroupPageController);

  // new Chat ------------------------------------------------------------------------------------------------------------------
  NewChatState newChatState = NewChatState();
  getIt.registerLazySingleton(() => newChatState);

  NewChatController newChatPageController = NewChatController();
  getIt.registerLazySingleton(() => newChatPageController);
  navigationService.registerController(RouteNames.newChat, newChatPageController);

  // new contact ------------------------------------------------------------------------------------------------------------------
  NewContactState newContactState = NewContactState();
  getIt.registerLazySingleton(() => newContactState);

  // Data Sources
  NewContactLocalDataSource newContactLocalDataSource = NewContactLocalDataSource(sharedPreferences: sp);
  NewContactRemoteDataSource newContactRemoteDataSource =
      NewContactRemoteDataSource(newContactLocalDataSource: newContactLocalDataSource);

  // Repository
  NewContactRepository newContactRepository = NewContactRepository(
    newContactRemoteDataSource: newContactRemoteDataSource,
    newContactLocalDataSource: newContactLocalDataSource,
    networkInfo: networkInfo
  );
  getIt.registerLazySingleton(() => newContactRepository);

  //controller

  NewContactController newContactPageController = NewContactController();
  getIt.registerLazySingleton(() => newContactPageController);
  navigationService.registerController(RouteNames.newContact, newContactPageController);

  // sign Up ------------------------------------------------------------------------------------------------------------------

  //state

  SignUpState signUpState = SignUpState();
  getIt.registerLazySingleton(() => signUpState);

  // Data Sources
  SignUpLocalDataSource signUpLocalDataSource = SignUpLocalDataSource(sharedPreferences: sp);
  SignUpRemoteDataSource signupRemoteDataSource = SignUpRemoteDataSource(signUpLocalDataSource: signUpLocalDataSource);

  // Repository
  SignupRepository signupRepository = SignupRepository(
      signupRemoteDataSource: signupRemoteDataSource,
      networkInfo: networkInfo,
      signUpLocalDataSource: signUpLocalDataSource);
  getIt.registerLazySingleton(() => signupRepository);

  //controller
  SignUpController signUpController = SignUpController();
  getIt.registerLazySingleton(() => signUpController);
  navigationService.registerController(RouteNames.signUp, signUpController);

  final FirebaseMessaging _firebasemessaging = FirebaseMessaging.instance;

  _firebasemessaging.getToken().then((deviceToken) {
    print("Device Token: $deviceToken");
    ConstStrings.fireBaseToken = deviceToken ?? "";
  });

  define_signalr_functions(connection, homeState, chatState);

  await connection.start();

  MyRouter.initialize();
}
