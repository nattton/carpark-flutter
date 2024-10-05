import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_kit/media_kit.dart';

part 'player_state.dart';

class PlayerCubit extends Cubit<PlayerState> {
  PlayerCubit() : super(PlayerState.initialize());

  void setMainPlayer(String url) {
    state.setMainPlayer(url);
  }

  void setSidePlayer(String url) {
    state.setSidePlayer(url);
  }

  void setCardPlayer(String url) {
    state.setCardPlayer(url);
  }

  void stopAll() {
    state.stopAll();
  }
}
