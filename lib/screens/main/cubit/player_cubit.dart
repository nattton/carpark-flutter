import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_kit/media_kit.dart';

part 'player_state.dart';

class PlayerCubit extends Cubit<PlayerState> {
  PlayerCubit() : super(PlayerState.initialize());

  void setMainPlayer(String url) {
    state.mainPlayer.open(Media(url));
  }

  void setSidePlayer(String url) {
    state.sidePlayer.open(Media(url));
  }

  void setCardPlayer(String url) {
    state.cardPlayer.open(Media(url));
  }

  void stopAll() {
    state.mainPlayer.stop();
    state.sidePlayer.stop();
    state.cardPlayer.stop();
  }
}
