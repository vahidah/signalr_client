import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../usecases/image_usecase.dart';

abstract class SignupRepositoryInterface {
  Future<Either<Failure, int>> image(ImageRequest request);



}
