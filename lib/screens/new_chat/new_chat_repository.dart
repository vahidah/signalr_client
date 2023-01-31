



import 'package:signalr_client/core/platform/network_info.dart';
import 'package:signalr_client/screens/new_chat/data_sources/local_data_source.dart';
import 'package:signalr_client/screens/new_chat/data_sources/remote_data_source.dart';
import 'package:signalr_client/screens/new_chat/interfaces/repository_interface.dart';

class NewChatRepository implements NewChatRepositoryInterface{

  NewChatRemoteDataSource newChatRemoteDataSource;
  NewChatLocalDataSource newChatLocalDataSource;
  NetworkInfo networkInfo;

  NewChatRepository({required this.newChatRemoteDataSource, required this.networkInfo, required this.newChatLocalDataSource});


}