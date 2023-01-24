import 'package:shared_preferences/shared_preferences.dart';
import 'package:signalr_client/core/interfaces/usecase.dart';
import 'package:signalr_client/screens/sign_up/usecases/image_usecase.dart';

import '../interfaces/signup_ds_interface.dart';

class SignUpLocalDataSource implements SignUpDataSourceInterface {
  final SharedPreferences sharedPreferences;

  SignUpLocalDataSource({required this.sharedPreferences});

  @override
  Future<NoParams> image({required ImageRequest imageRequest}) {
    throw UnimplementedError();
  }
}
