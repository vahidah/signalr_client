

import 'package:dartz/dartz.dart';


import '../../core/error/exception.dart';
import '../../core/error/failures.dart';
import 'package:signalr_client/screens/new_contact/interfaces/new_contact_repository_interface.dart';
import 'package:signalr_client/screens/new_contact/usecases/get_image_usecase.dart';
import 'data_sources/new_contact_remote_ds.dart';

class NewContactRepository implements NewContactRepositoryInterFace{

  final NewContactRemoteDataSource newContactRemoteDataSource;

  NewContactRepository(this.newContactRemoteDataSource);

  @override
  Future<Either<Failure, String>> getImage(GetImageRequest request) async {


    try{
      String response = await newContactRemoteDataSource.getImage(request: request);
      return Right(response);
    }on AppException catch (e) {
      return Left(ServerFailure.fromAppException(e));
    }

  }

}