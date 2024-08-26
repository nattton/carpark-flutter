import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class PlayerState {
  final Player mainPlayer;
  final VideoController mainController;
  final Player sidePlayer;
  final VideoController sideController;
  final Player cardPlayer;
  final VideoController cardController;

  PlayerState({
    required this.mainPlayer,
    required this.mainController,
    required this.sidePlayer,
    required this.sideController,
    required this.cardPlayer,
    required this.cardController,
  });

  factory PlayerState.initialize() {
    final Player mainPlayer = Player();
    final VideoController mainController = VideoController(mainPlayer);
    final Player sidePlayer = Player();
    final VideoController sideController = VideoController(sidePlayer);
    final Player cardPlayer = Player();
    final VideoController cardController = VideoController(cardPlayer);
    return PlayerState(
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
