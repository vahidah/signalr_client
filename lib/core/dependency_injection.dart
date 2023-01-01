import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';


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
import 'navigation/router.dart';
import '../core/navigation/navigation_service.dart';
import 'constants/route_names.dart';
import '../../core/platform/network_info.dart';



final getIt = GetIt.instance;


Future<void> init() async{


  NavigationService navigationService = NavigationService();
  getIt.registerSingleton(navigationService);

  Connectivity connectivity = Connectivity();
  NetworkInfo networkInfo = NetworkInfo(connectivity);


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
  getIt.registerLazySingleton(() => newChatPageController );
  navigationService.registerController(RouteNames.newChat, newChatPageController);

  // new Chat ------------------------------------------------------------------------------------------------------------------
  NewContactState newContactState = NewContactState();
  getIt.registerLazySingleton(() => newContactState);


  NewContactController newContactPageController = NewContactController();
  getIt.registerLazySingleton(() =>newContactPageController);
  navigationService.registerController(RouteNames.newContact, newContactPageController);

  // sign Up ------------------------------------------------------------------------------------------------------------------

  //state

  SignUpState  signUpState = SignUpState();
  getIt.registerLazySingleton(() => signUpState );

  // Data Sources
  SignUpRemoteDataSource signupRemoteDataSource = SignUpRemoteDataSource();

  // Repository
  SignupRepository signupRepository = SignupRepository(
    signupRemoteDataSource: signupRemoteDataSource,
    networkInfo: networkInfo,
  );
  getIt.registerLazySingleton(() => signupRepository);

  //controller
  SignUpController signUpController = SignUpController();
  getIt.registerLazySingleton(() => signUpController);
  navigationService.registerController(RouteNames.signUp, signUpController);


  MyRouter.initialize();

}