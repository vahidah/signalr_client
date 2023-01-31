

import 'package:signalr_client/core/platform/network_info.dart';
import 'package:signalr_client/screens/chat/data_sources/chat_local_ds.dart';
import 'package:signalr_client/screens/chat/data_sources/chat_remote_ds.dart';
import 'package:signalr_client/screens/chat/interfaces/chat_repository_interface.dart';

class ChatRepository implements ChatRepositoryInterFace{

  ChatLocalDataSource chatLocalDataSource;
  ChatRemoteDataSource chatRemoteDataSource;
  NetworkInfo networkInfo;

  ChatRepository({required this.networkInfo, required this.chatRemoteDataSource, required this.chatLocalDataSource});

}