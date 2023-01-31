import 'package:signalr_client/screens/chat/data_sources/chat_local_ds.dart';

import '../interfaces/chat_ds_interface.dart';


class ChatRemoteDataSource implements ChatDataSourceInterFace{

  ChatLocalDataSource chatLocalDataSource;

  ChatRemoteDataSource({required this.chatLocalDataSource});

}