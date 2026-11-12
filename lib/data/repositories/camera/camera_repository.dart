import 'package:carpark/domain/models/camera_model.dart';
import 'package:carpark/utils/result.dart';

abstract class CameraRepository {
  Future<Result<List<CameraModel>>> getCameraList();
  Future<Result<CameraModel>> updateCamera(CameraModel camera);
}
