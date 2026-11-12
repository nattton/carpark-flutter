import 'package:carpark/data/repositories/camera/camera_repository.dart';
import 'package:carpark/domain/models/models.dart';
import 'package:carpark/utils/result.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

@singleton
class LivePlayerViewmodel extends ChangeNotifier {
  new({required CameraRepository cameraRepository})
    : _cameraRepository = cameraRepository {
    playEntranceCommand = Command.createAsyncNoParamNoResult(() async {
      final cameraMain = cameraMap.value['ENTRANCE'];
      if (cameraMain != null) {
        await mainPlayer.open(Media(cameraMain.toUrl()));
      }
      final cameraSide = cameraMap.value['IN_SIDE'];
      if (cameraSide != null) {
        await sidePlayer.open(Media(cameraSide.toUrl()));
      }
      final cameraCard = cameraMap.value['CARD'];
      if (cameraCard != null) {
        await cardPlayer.open(Media(cameraCard.toUrl()));
      }
    });

    playExitCommand = Command.createAsyncNoParamNoResult(() async {
      final cameraMain = cameraMap.value['EXIT'];
      if (cameraMain != null) {
        await mainPlayer.open(Media(cameraMain.toUrl()));
      }
      final cameraSide = cameraMap.value['OUT_SIDE'];
      if (cameraSide != null) {
        await sidePlayer.open(Media(cameraSide.toUrl()));
      }
    });

    stopAllCommand = Command.createAsyncNoParamNoResult(() async {
      await mainPlayer.stop();
      await sidePlayer.stop();
      await cardPlayer.stop();
    });

    getCameraCommand = Command.createAsyncNoParamNoResult(() async {
      final result = await _cameraRepository.getCameraList();
      switch (result) {
        case Ok<List<CameraModel>>():
          cameraList.value = result.value;
          cameraMap.value = {for (final cam in cameraList.value) cam.name: cam};
        case Error<List<CameraModel>>():
          _log.warning('Get camera failed! ${result.error}');
          throw result.error;
      }
    })..pipeToCommand(playEntranceCommand);
  }

  final CameraRepository _cameraRepository;
  final _log = Logger('LivePlayerViewmodel');

  final mainPlayer = Player();
  final sidePlayer = Player();
  final cardPlayer = Player();

  late final mainController = VideoController(mainPlayer);
  late final sideController = VideoController(sidePlayer);
  late final cardController = VideoController(cardPlayer);
  final cameraList = ValueNotifier<List<CameraModel>>([]);
  final cameraMap = ValueNotifier<Map<String, CameraModel>>({});

  late Command<void, void> playEntranceCommand;
  late Command<void, void> playExitCommand;
  late Command<void, void> stopAllCommand;
  late Command<void, void> getCameraCommand;
}
