




import 'package:signalr_client/screens/create_group/data_sources/create_group_local_ds.dart';
import 'package:signalr_client/screens/create_group/interfaces/create_group_ds_interface.dart';

class CreateGroupRemoteDataSource implements CreateGroupDataSourceInterface{

  CreateGroupLocalDataSource createGroupLocalDataSource;

  CreateGroupRemoteDataSource({required this.createGroupLocalDataSource});

}