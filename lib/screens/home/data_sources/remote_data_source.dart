



import 'package:signalr_client/screens/home/data_sources/local_data_source.dart';
import 'package:signalr_client/screens/home/interfaces/home_data_source_interface.dart';

class HomeRemoteDataSource implements HomeDataSourceInterFace{
    HomeLocalDataSource homeLocalDataSource;

    HomeRemoteDataSource({required this.homeLocalDataSource});
}