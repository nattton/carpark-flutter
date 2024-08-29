part of 'player_cubit.dart';

class PlayerState {
  final Player mainPlayer;
  final Player sidePlayer;
  final Player cardPlayer;

  PlayerState({
    required this.mainPlayer,
    required this.sidePlayer,
    required this.cardPlayer,
  });

  factory PlayerState.initialize() {
    final Player mainPlayer = Player();
    final Player sidePlayer = Player();
    final Player cardPlayer = Player();
    return PlayerState(
      mainPlayer: mainPlayer,
      sidePlayer: sidePlayer,
      cardPlayer: cardPlayer,
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
