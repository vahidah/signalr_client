

import 'package:dartz/dartz.dart';
import 'package:signalr_client/screens/add_contact/data_sources/add_contact_local_ds.dart';


import '../../core/error/exception.dart';
import '../../core/error/failures.dart';
import 'package:signalr_client/screens/add_contact/interfaces/new_contact_repository_interface.dart';
import 'package:signalr_client/screens/add_contact/usecases/get_image_usecase.dart';
import '../../core/platform/network_info.dart';
import 'data_sources/add_contact_remote_ds.dart';

class NewContactRepository implements NewContactRepositoryInterFace{

  final NewContactRemoteDataSource newContactRemoteDataSource;
  final NewContactLocalDataSource newContactLocalDataSource;
  final NetworkInfo networkInfo;

  NewContactRepository({required this.newContactRemoteDataSource, required this.newContactLocalDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, String>> getImage(GetImageRequest request) async {

  if(await networkInfo.isConnected) {
    try {
      String response = await newContactRemoteDataSource.getImage(request: request);
      return Right(response);
    } on AppException catch (e) {
      return Left(ServerFailure.fromAppException(e));
    }
  }else{
    return Left(ConnectionFailure.fromAppException(
        ConnectionException(message: "no internet!", trace: StackTrace.fromString("SignupRepository.image"))));
  }

  }

}