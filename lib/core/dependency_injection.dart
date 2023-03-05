import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:messaging_signalr/messaging_signalr.dart';
import 'package:signalr_client/core/util/package_error_snackbar.dart';
import 'package:signalr_client/screens/chat/chat_repository.dart';
import 'package:signalr_client/screens/chat/data_sources/chat_local_ds.dart';
import 'package:signalr_client/screens/chat/data_sources/chat_remote_ds.dart';
import 'package:signalr_client/screens/create_group/create_group_repository.dart';
import 'package:signalr_client/screens/create_group/data_sources/create_group_local_ds.dart';
import 'package:signalr_client/screens/create_group/data_sources/create_group_remote_ds.dart';
import 'package:signalr_client/screens/home/data_sources/local_data_source.dart';
import 'package:signalr_client/screens/home/data_sources/remote_data_source.dart';
import 'package:signalr_client/screens/home/home_repository.dart';
import 'package:signalr_client/screens/new_chat/data_sources/local_data_source.dart';
import 'package:signalr_client/screens/new_chat/data_sources/remote_data_source.dart';
import 'package:signalr_client/screens/new_chat/new_chat_repository.dart';
import 'package:signalr_client/screens/add_contact/data_sources/add_contact_local_ds.dart';
import 'package:signalr_client/screens/sign_up/data_sources/signup_local_ds.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../screens/home/home_state.dart';
import '../screens/home/home_controller.dart';
import '../screens/chat/chat_state.dart';
import '../screens/chat/chat_controller.dart';
import '../screens/create_group/create_group_state.dart';
import '../screens/create_group/create_group_controller.dart';
import '../screens/new_chat/new_chat_state.dart';
import '../screens/new_chat/new_chat_controller.dart';
import '../screens/add_contact/new_contact_state.dart';
import '../screens/add_contact/new_contact_controller.dart';
import '../screens/sign_up/sign_up_state.dart';
import '../screens/sign_up/sign_up_controller.dart';
import '../screens/sign_up/data_sources/signup_remote_ds.dart';
import '../screens/sign_up/sign_up_repository.dart';
import 'constants/constant_values.dart';
import 'database/share_pref.dart';
import 'navigation/router.dart';
import '../core/navigation/navigation_service.dart';
import 'constants/route_names.dart';
import '../../core/platform/network_info.dart';
import 'package:signalr_client/screens/add_contact/data_sources/add_contact_remote_ds.dart';
import 'package:signalr_client/screens/add_contact/new_contact_repositroy.dart';

final getIt = GetIt.instance;

Future<void> init() async {



  SharedPreferences sp = await SharedPreferences.getInstance();

  SharedPrefService sharedPrefService = SharedPrefService(sp);

  NavigationService navigationService = NavigationService();
  getIt.registerSingleton(navigationService);
  getIt.registerLazySingleton(() => sharedPrefService);

  Connectivity connectivity = Connectivity();
  NetworkInfo networkInfo = NetworkInfo(connectivity);

  debugPrint("here0");

  // home ------------------------------------------------------------------------------------------------------------------
  ///state
  HomeState homeState = HomeState();
  getIt.registerLazySingleton(() => homeState);


  ///Data Sources
  HomeLocalDataSource homeLocalDataSource = HomeLocalDataSource(sharedPreferences: sp);
  HomeRemoteDataSource homeRemoteDataSource = HomeRemoteDataSource(homeLocalDataSource: homeLocalDataSource);

  ///Repository
  HomeRepository homeRepository = HomeRepository(
      networkInfo: networkInfo, homeLocalDataSource: homeLocalDataSource, homeRemoteDataSource: homeRemoteDataSource);
  getIt.registerLazySingleton(() => homeRepository);



  // chat ------------------------------------------------------------------------------------------------------------------
  ///State
  ChatState chatState = ChatState();
  getIt.registerLazySingleton(() => chatState);

  ///Data Sources
  ChatLocalDataSource chatLocalDataSource = ChatLocalDataSource(sharedPreferences: sp);
  ChatRemoteDataSource chatRemoteDataSource = ChatRemoteDataSource(chatLocalDataSource: chatLocalDataSource);

  ///Repository
  ChatRepository chatRepository = ChatRepository(
      networkInfo: networkInfo, chatRemoteDataSource: chatRemoteDataSource, chatLocalDataSource: chatLocalDataSource);
  getIt.registerLazySingleton(() => chatRepository);



  // create Group ------------------------------------------------------------------------------------------------------------------
  ///state
  CreateGroupState createGroupState = CreateGroupState();
  getIt.registerLazySingleton(() => createGroupState);

  ///Data Sources
  CreateGroupLocalDataSource createGroupLocalDataSource = CreateGroupLocalDataSource(sharedPreferences: sp);
  CreateGroupRemoteDataSource createGroupRemoteDataSource =
      CreateGroupRemoteDataSource(createGroupLocalDataSource: createGroupLocalDataSource);

  ///Repository
  CreateGroupRepository createGroupRepository = CreateGroupRepository(
      networkInfo: networkInfo,
      createGroupLocalDataSource: createGroupLocalDataSource,
      createGroupRemoteDataSource: createGroupRemoteDataSource);
  getIt.registerLazySingleton(() => createGroupRepository);


  // new Chat ------------------------------------------------------------------------------------------------------------------

  //state
  NewChatState newChatState = NewChatState();
  getIt.registerLazySingleton(() => newChatState);

  //Data Sources
  NewChatLocalDataSource newChatLocalDataSource = NewChatLocalDataSource(sharedPreferences: sp);
  NewChatRemoteDataSource newChatRemoteDataSource = NewChatRemoteDataSource(localDataSource: newChatLocalDataSource);

  //Repository
  NewChatRepository newChatRepository = NewChatRepository(
      newChatRemoteDataSource: newChatRemoteDataSource,
      networkInfo: networkInfo,
      newChatLocalDataSource: newChatLocalDataSource);

  getIt.registerLazySingleton(() => newChatRepository);



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
      networkInfo: networkInfo);
  getIt.registerLazySingleton(() => newContactRepository);




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



  //end screens section

  debugPrint("here1");

  final FirebaseMessaging _firebasemessaging = FirebaseMessaging.instance;



  debugPrint("here2");

  await _firebasemessaging.getToken().then((deviceToken) {
    debugPrint("Device Token: $deviceToken");
    ConstValues.fireBaseToken = deviceToken ?? "";
  });
  debugPrint("here3");


  SignalRMessaging.init(
      serverAddress: 'http://10.0.2.2:5000/Myhub',
      firebaseToken: ConstValues.fireBaseToken,
      onSendMessage: (){
        chatState.setChat = SignalRMessaging().chats.firstWhere((element) => element.chatId == chatState.chatKey.value);
        homeState.setState();},
      onGetContactInfo: (){
        navigationService.goToName(RouteNames.home);
        newContactState.getContactInfoCompleted.toggle();
      },
      onReceiveNewMessage: (){
        homeState.setState();
        chatState.setState();
      },
      onGetContactInfoCanceled: (String message){
          PackageErrorSnackBar.showSnackBar(message, true);
          newContactState.getContactInfoCompleted.toggle();
      },
      onCreateGroup: (String message){

        navigationService.goToName(RouteNames.home);
        createGroupState.setCrateGroupCompleted = true;
        PackageErrorSnackBar.showSnackBar(message, false);
      }
  );
    //serverAddress: 'http://10.0.2.2:5000/Myhub',
  // 10.0.2.2:5124/ChatHub
  //167.235.239.170:5025

  debugPrint("in dependency injection 5");

  getIt.registerLazySingleton(() => SignalRMessaging());


  debugPrint("in dependency injection 6");
  //controllers
  //home
  HomeController homePageController = HomeController();
  getIt.registerLazySingleton(() => homePageController);
  navigationService.registerController(RouteNames.home, homePageController);
  //chat
  ChatController chatPageController = ChatController();
  getIt.registerLazySingleton(() => chatPageController);
  navigationService.registerController(RouteNames.chat, chatPageController);
  //createGroup
  CreateGroupController createGroupPageController = CreateGroupController();
  getIt.registerLazySingleton(() => createGroupPageController);
  navigationService.registerController(RouteNames.createGroup, createGroupPageController);
  //new chat
  NewChatController newChatPageController = NewChatController();
  getIt.registerLazySingleton(() => newChatPageController);
  navigationService.registerController(RouteNames.newChat, newChatPageController);
  //new contact
  NewContactController newContactPageController = NewContactController();
  getIt.registerLazySingleton(() => newContactPageController);
  navigationService.registerController(RouteNames.newContact, newContactPageController);
  //signup
  SignUpController signUpController = SignUpController();
  getIt.registerLazySingleton(() => signUpController);
  navigationService.registerController(RouteNames.signUp, signUpController);

  debugPrint("in dependency injection 7");

  MyRouter.initialize();
}
