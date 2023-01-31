



import 'package:signalr_client/core/platform/network_info.dart';
import 'package:signalr_client/screens/home/data_sources/local_data_source.dart';
import 'package:signalr_client/screens/home/data_sources/remote_data_source.dart';
import 'package:signalr_client/screens/home/interfaces/home_repository_interface.dart';

class HomeRepository implements HomeRepositoryInterFace{
      HomeRemoteDataSource homeRemoteDataSource;
      HomeLocalDataSource homeLocalDataSource;
      NetworkInfo networkInfo;

      HomeRepository({required this.networkInfo, required this.homeLocalDataSource, required this.homeRemoteDataSource});
}