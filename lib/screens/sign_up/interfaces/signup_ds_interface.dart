

import 'package:signalr_client/core/interfaces/usecase.dart';

import '../usecases/image_usecase.dart';


abstract class SignUpDataSourceInterface {
  Future<NoParams> image({required ImageRequest imageRequest});


}
