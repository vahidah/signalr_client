import 'package:dartz/dartz.dart';
import 'package:signalr_client/screens/sign_up/data_sources/signup_local_ds.dart';

import '../../core/error/exception.dart';
import '../../core/error/failures.dart';
import '../../core/interfaces/usecase.dart';
import 'interfaces/signup_repository_interface.dart';
import 'data_sources/signup_remote_ds.dart';
import 'usecases/image_usecase.dart';
import '../../core/platform/network_info.dart';

class SignupRepository implements SignupRepositoryInterface {
  final SignUpRemoteDataSource signupRemoteDataSource;
  final SignUpLocalDataSource signUpLocalDataSource;

  final NetworkInfo networkInfo;

  SignupRepository({required this.signupRemoteDataSource, required this.networkInfo, required this.signUpLocalDataSource});

  @override
  Future<Either<Failure, NoParams>> image(ImageRequest imgRequest) async {
    if (await networkInfo.isConnected) {
      try {
       await signupRemoteDataSource.image(imageRequest: imgRequest);
        return Right(NoParams());
      } on AppException catch (e) {
        return Left(ServerFailure.fromAppException(e));
      }
    } else {

      return Left(ConnectionFailure.fromAppException(
          ConnectionException(message: "no internet!", trace: StackTrace.fromString("SignupRepository.image"))));
    }
  }
}
