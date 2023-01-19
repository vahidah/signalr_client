import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:signalr_client/core/error/exception.dart';

import '../interfaces/new_contact_ds_interface.dart';
import '../usecases/get_image_usecase.dart';
import '/core/constants/Apis.dart';

class NewContactRemoteDataSource implements NewContactDataSourceInterFace{


  @override
  Future<String> getImage({required GetImageRequest request}) async {
      http.Response response = await http.post(
        Uri.parse("${Apis.getImage}/${request.contactId}",),

      );

      if(response.statusCode == 200){
        return base64.encode(response.bodyBytes);
      }else{
        return "";
      }

  }
}