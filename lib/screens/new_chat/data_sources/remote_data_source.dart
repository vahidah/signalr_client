


import 'package:signalr_client/screens/new_chat/data_sources/local_data_source.dart';
import 'package:signalr_client/screens/new_chat/interfaces/data_source_interface.dart';

class NewChatRemoteDataSource implements NewChatDataSourceInterface{

  NewChatLocalDataSource localDataSource;

  NewChatRemoteDataSource({required this.localDataSource});

}