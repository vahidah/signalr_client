import 'package:dartz/dartz.dart';
import 'package:signalr_client/core/interfaces/usecase.dart';

import '../../../core/error/failures.dart';
import '../usecases/image_usecase.dart';

abstract class SignupRepositoryInterface {
  Future<Either<Failure, NoParams>> image(ImageRequest request);



}
