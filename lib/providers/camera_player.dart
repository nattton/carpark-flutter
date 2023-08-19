import 'package:dart_vlc/dart_vlc.dart';

class CameraPlayer {
  final Player mainPlayer;
  final Player sidePlayer;
  final Player cardPlayer;
  const CameraPlayer(
      {required this.mainPlayer,
      required this.sidePlayer,
      required this.cardPlayer});

  void setMainPlayer(String url) {
    mainPlayer.open(Media.network(url));
  }

  void setSidePlayer(String url) {
    sidePlayer.open(Media.network(url));
  }

  void setCardPlayer(String url) {
    cardPlayer.open(Media.network(url));
  }

  void stopAll() {
    mainPlayer.stop();
    sidePlayer.stop();
    cardPlayer.stop();
  }
}
