import 'package:signalr_client/screens/sign_up/usecases/image_usecase.dart';

import '../interfaces/signup_ds_interface.dart';

class SignUpLocalDataSource implements SignUpDataSourceInterface {
  //final SharedPreferences sharedPreferences;
  //final ObjectBox objectBox;
  //todo add sharedPreferences

  SignUpLocalDataSource();

  @override
  Future<int> image({required ImageRequest imageRequest}) {
    throw UnimplementedError();
  }
}
