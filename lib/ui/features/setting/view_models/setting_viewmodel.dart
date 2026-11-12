import 'package:carpark/data/repositories/camera/camera_repository.dart';
import 'package:carpark/domain/models/camera_model.dart';
import 'package:carpark/ui/features/live_player/view_models/live_player_viewmodel.dart';
import 'package:carpark/utils/result.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@injectable
class SettingViewModel extends ChangeNotifier {
  new({
    required CameraRepository cameraRepository,
    required LivePlayerViewmodel livePlayerViewModel,
  }) : _cameraRepository = cameraRepository,
       _livePlayerViewModel = livePlayerViewModel;

  final CameraRepository _cameraRepository;
  final LivePlayerViewmodel _livePlayerViewModel;

  Future<Result<CameraModel>> updateCamera(CameraModel camera) async {
    final result = await _cameraRepository.updateCamera(camera);
    if (result is Ok<CameraModel>) {
      _livePlayerViewModel.getCameraCommand.run();
    }
    return result;
  }
}
