import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '/core/error/failures.dart';
import '/core/interfaces/request.dart';
import '/core/interfaces/usecase.dart';
import '../sign_up_repository.dart';

class ImageUseCase extends UseCase<void, ImageRequest> {
  final SignupRepository repository;

  ImageUseCase({required this.repository});

  @override
  Future<Either<Failure, int>> call({required ImageRequest request}) => repository.image(request);
}


class ImageRequest /*extends Request*/ {



  ImageRequest({required this.id, required this.image});

  final int id;
  final File image;

  @override
  Future<FormData> formData() async {
    
    // var map = FormData.fromMap({
    //   "image" : image,
    //   "id" : id
    //
    // });
    FormData map = FormData.fromMap({
      "file":
      await MultipartFile.fromFile(image.path, filename:image.path.split('/').last),
      "id": id
    });

    


    return map;
  }

  // @override
  // Map<String, dynamic> toJson() {
  //   // TODO: implement toJson
  //   throw UnimplementedError();
  // }




}
