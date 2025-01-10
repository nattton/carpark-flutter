import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'id_card_event.dart';
part 'id_card_state.dart';

class IdCardBloc extends Bloc<IdCardEvent, IdCardState> {
  IdCardBloc() : super(IdCardInitial()) {
    on<IdCardEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
