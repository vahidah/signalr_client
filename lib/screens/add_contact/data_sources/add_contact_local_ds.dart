

import 'package:shared_preferences/shared_preferences.dart';
import 'package:signalr_client/screens/add_contact/usecases/get_image_usecase.dart';

import '../interfaces/new_contact_ds_interface.dart';

class NewContactLocalDataSource implements NewContactDataSourceInterFace{

  final SharedPreferences sharedPreferences;

  NewContactLocalDataSource({required this.sharedPreferences});


  @override
  Future<String> getImage({required GetImageRequest request}) {
    //no local data source required yet
    throw UnimplementedError();
  }


}