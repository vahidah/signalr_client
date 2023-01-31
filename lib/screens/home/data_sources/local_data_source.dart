


import 'package:shared_preferences/shared_preferences.dart';
import 'package:signalr_client/screens/home/interfaces/home_data_source_interface.dart';

class HomeLocalDataSource implements HomeDataSourceInterFace{
  final SharedPreferences sharedPreferences;

  HomeLocalDataSource({required this.sharedPreferences});
}