import 'package:shared_preferences/shared_preferences.dart';

import '../interfaces/chat_ds_interface.dart';

class ChatLocalDataSource implements ChatDataSourceInterFace{
  final SharedPreferences sharedPreferences;

  ChatLocalDataSource({required this.sharedPreferences});
}