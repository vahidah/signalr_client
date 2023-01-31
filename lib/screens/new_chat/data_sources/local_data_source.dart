import 'package:shared_preferences/shared_preferences.dart';

import 'package:signalr_client/screens/new_chat/interfaces/data_source_interface.dart';

class NewChatLocalDataSource implements NewChatDataSourceInterface{
  final SharedPreferences sharedPreferences;

  NewChatLocalDataSource({required this.sharedPreferences});


}