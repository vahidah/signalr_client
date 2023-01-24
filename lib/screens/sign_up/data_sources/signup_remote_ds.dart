import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:signalr_client/core/interfaces/usecase.dart';
import 'package:signalr_client/screens/sign_up/data_sources/signup_local_ds.dart';


import '/core/constants/apis.dart';
import '/core/error/exception.dart';
import '../interfaces/signup_ds_interface.dart';
import '../usecases/image_usecase.dart';


class SignUpRemoteDataSource implements SignUpDataSourceInterface {

  final SignUpLocalDataSource signUpLocalDataSource;

  SignUpRemoteDataSource({required this.signUpLocalDataSource});


  @override
  Future<NoParams> image({required ImageRequest imageRequest}) async {
    Dio dio = Dio();

    // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
    //   client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    //   return client;
    // };
    try {
      var data = await imageRequest.formData();


      final response = await dio.post(Apis.getImage, data: data);

      debugPrint("status code is ${response.statusCode}");
      debugPrint("");

      if (response.statusCode == 200) {
        debugPrint("successfully upload image");
        return NoParams();
      } else {
        debugPrint("upload image failed");
        return NoParams();
      }
    } catch (e, t) {
      throw ServerException(code: -100, trace: t);
    }
  }

}
