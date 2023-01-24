

import 'package:shared_preferences/shared_preferences.dart';
import 'package:signalr_client/screens/new_contact/usecases/get_image_usecase.dart';

import '../interfaces/new_contact_ds_interface.dart';

class NewContactLocalDataSource implements NewContactDataSourceInterFace{

  final SharedPreferences sharedPreferences;

  NewContactLocalDataSource({required this.sharedPreferences});


  @override
  Future<String> getImage({required GetImageRequest request}) {
    // TODO: implement getImage
    throw UnimplementedError();
  }


}