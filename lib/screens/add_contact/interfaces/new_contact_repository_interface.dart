import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../usecases/get_image_usecase.dart';



abstract class NewContactRepositoryInterFace{

  Future<Either<Failure,String>> getImage(GetImageRequest request);

}
