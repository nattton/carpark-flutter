import 'package:carpark/data/repositories/camera/camera_repository.dart';
import 'package:carpark/data/services/api/api_service.dart';
import 'package:carpark/domain/models/camera_model.dart';
import 'package:carpark/utils/failures.dart';
import 'package:carpark/utils/result.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CameraRepository)
class CameraRepositoryRemote extends CameraRepository {
  new({required ApiService apiService})
    : _apiService = apiService;

  final ApiService _apiService;

  @override
  Future<Result<List<CameraModel>>> getCameraList() async {
    try {
      final cameras = await _apiService.getCameraList();
      return Result.ok(cameras);
    } on Object catch (e) {
      return Result.error(Failure.fromException(e));
    }
  }

  @override
  Future<Result<CameraModel>> updateCamera(CameraModel camera) async {
    try {
      final updated = await _apiService.updateCamera(camera.id, camera);
      return Result.ok(updated);
    } on Object catch (e) {
      return Result.error(Failure.fromException(e));
    }
  }
}
