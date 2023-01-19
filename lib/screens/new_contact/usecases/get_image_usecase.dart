
import 'package:signalr_client/screens/new_contact/new_contact_repositroy.dart';
import 'package:dartz/dartz.dart';

import '/core/error/failures.dart';
import '../../../core/interfaces/usecase.dart';

class GetImageUseCase extends UseCase<String, GetImageRequest> {
  final NewContactRepository repository;

  GetImageUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call({required GetImageRequest request}) => repository.getImage(request);
}




class GetImageRequest{

  final int contactId;

  GetImageRequest({required this.contactId});



}