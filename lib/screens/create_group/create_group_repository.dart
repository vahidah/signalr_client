
import 'package:signalr_client/core/platform/network_info.dart';
import 'package:signalr_client/screens/create_group/data_sources/create_group_local_ds.dart';
import 'package:signalr_client/screens/create_group/data_sources/create_group_remote_ds.dart';

import 'interfaces/create_group_repository_interface.dart';


class CreateGroupRepository implements CreateGroupRepositoryInterface{

  CreateGroupRemoteDataSource createGroupRemoteDataSource;
  CreateGroupLocalDataSource createGroupLocalDataSource;
  NetworkInfo networkInfo;

  CreateGroupRepository({required this.networkInfo, required this.createGroupLocalDataSource, required this.createGroupRemoteDataSource});
}