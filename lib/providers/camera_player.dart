import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class CameraPlayer {
  final Player mainPlayer;
  final VideoController mainController;
  final Player sidePlayer;
  final VideoController sideController;
  final Player cardPlayer;
  final VideoController cardController;

  CameraPlayer({
    required this.mainPlayer,
    required this.mainController,
    required this.sidePlayer,
    required this.sideController,
    required this.cardPlayer,
    required this.cardController,
  });

  factory CameraPlayer.initialize() {
    final mainPlayer = Player();
    final mainController = VideoController(mainPlayer);
    final sidePlayer = Player();
    final sideController = VideoController(sidePlayer);
    final cardPlayer = Player();
    final cardController = VideoController(cardPlayer);
    return CameraPlayer(
      mainPlayer: mainPlayer,
      mainController: mainController,
      sidePlayer: sidePlayer,
      sideController: sideController,
      cardPlayer: cardPlayer,
      cardController: cardController,
    );
  }

  void setMainPlayer(String url) {
    mainPlayer.open(Media(url));
  }

  void setSidePlayer(String url) {
    sidePlayer.open(Media(url));
  }

  void setCardPlayer(String url) {
    cardPlayer.open(Media(url));
  }

  void stopAll() {
    mainPlayer.stop();
    sidePlayer.stop();
    cardPlayer.stop();
  }
}
