import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


import '/core/constants/apis.dart';
import '/core/error/exception.dart';
import '../interfaces/signup_ds_interface.dart';
import '../usecases/image_usecase.dart';


class SignUpRemoteDataSource implements SignUpDataSourceInterface {



  @override
  Future<int> image({required ImageRequest imageRequest}) async {
    Dio dio = Dio();

    // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
    //   client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    //   return client;
    // };
    try {
      var data = await imageRequest.formData();


      final response = await dio.post(Apis.getImage, data: data);
      //todo put request in try catch

      debugPrint("status code is ${response.statusCode}");
      debugPrint("");

      if (response.statusCode == 200) {
        return 1;
      } else {
        debugPrint("upload image failed");
        return 0;
      }
    } catch (e, t) {
      throw ServerException(code: -100, trace: t);
    }
  }

}
