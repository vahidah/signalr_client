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
  Future<Either<Failure, void>> call({required ImageRequest request}) => repository.image(request);
  //todo try void and no params
}

class ImageRequest {
  ImageRequest({required this.id, required this.image});

  final int id;
  final File image;

  Future<FormData> formData() async {
    FormData map = FormData.fromMap(
        {"file": await MultipartFile.fromFile(image.path, filename: image.path.split('/').last), "id": id});

    return map;
  }
}
