import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:signalr_client/core/error/exception.dart';
import 'package:signalr_client/screens/new_contact/data_sources/new_contact_local_ds.dart';

import '../interfaces/new_contact_ds_interface.dart';
import '../usecases/get_image_usecase.dart';
import '/core/constants/Apis.dart';

class NewContactRemoteDataSource implements NewContactDataSourceInterFace{

  final NewContactLocalDataSource newContactLocalDataSource;

  NewContactRemoteDataSource({required this.newContactLocalDataSource});

  @override
  Future<String> getImage({required GetImageRequest request}) async {
    try {
      http.Response response = await http.post(
        Uri.parse("${Apis.getImage}/${request.contactId}",),

      );


      if(response.statusCode == 200){
        return base64.encode(response.bodyBytes);
      }else{
        throw ServerException(code: 100, trace: StackTrace.fromString("NewContactRemoteDataSource:getImage"));
      }
    } catch (e, t) {
      throw ServerException(code: 100, trace: t);
    }


  }
}