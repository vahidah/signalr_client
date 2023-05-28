
import '../usecases/get_image_usecase.dart';

abstract class NewContactDataSourceInterFace{

  Future<String> getImage({required GetImageRequest request});

}