import 'package:dartz/dartz.dart';

import '../../core/error/exception.dart';
import '../../core/error/failures.dart';
import 'interfaces/signup_repository_interface.dart';
import 'data_sources/signup_remote_ds.dart';
import 'usecases/image_usecase.dart';
import '../../core/platform/network_info.dart';

class SignupRepository implements SignupRepositoryInterface {
  final SignUpRemoteDataSource signupRemoteDataSource;

  final NetworkInfo networkInfo;

  SignupRepository({required this.signupRemoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, int>> image(ImageRequest imgRequest) async {
    if (await networkInfo.isConnected) {
      try {
        int response = await signupRemoteDataSource.image(imageRequest: imgRequest);
        return Right(response);
      } on AppException catch (e) {
        return Left(ServerFailure.fromAppException(e));
      }
      //we have just app exception
    } else {

      return Left(ConnectionFailure.fromAppException(
          ConnectionException(message: "no internet!", trace: StackTrace.fromString("SignupRepository.image"))));
    }
  }
}
