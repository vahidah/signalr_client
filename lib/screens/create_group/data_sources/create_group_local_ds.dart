

import 'package:shared_preferences/shared_preferences.dart';
import 'package:signalr_client/screens/create_group/interfaces/create_group_ds_interface.dart';

class CreateGroupLocalDataSource implements CreateGroupDataSourceInterface{

  final SharedPreferences sharedPreferences;

  CreateGroupLocalDataSource({required this.sharedPreferences});



}