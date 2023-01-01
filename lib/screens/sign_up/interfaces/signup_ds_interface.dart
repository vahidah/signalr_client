

import '../usecases/image_usecase.dart';


abstract class SignUpDataSourceInterface {
  Future<int> image({required ImageRequest imageRequest});

}
