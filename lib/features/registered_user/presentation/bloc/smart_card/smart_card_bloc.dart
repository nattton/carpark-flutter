import 'package:carpark/injection_container.dart';
import 'package:carpark/services/api_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'smart_card_event.dart';
part 'smart_card_state.dart';

class SmartCardBloc extends Bloc<SmartCardEvent, SmartCardState> {
  SmartCardBloc()
      : super(const SmartCardState(
            state: SmartCardStateX.initial,
            id: "",
            engName: "",
            thaiName: "",
            birthdate: "",
            gender: "",
            address: "",
            photoPath: "",
            photoByte: "")) {
    on<ReadSmartCard>(_readSmartCard);
  }

  Future<void> _readSmartCard(
      ReadSmartCard event, Emitter<SmartCardState> emit) async {
    emit(const SmartCardState(
        state: SmartCardStateX.reading,
        id: "",
        engName: "",
        thaiName: "",
        birthdate: "",
        gender: "",
        address: "",
        photoPath: "",
        photoByte: ""));
    try {
      final idCardResponse = await sl<ApiService>().smartCardReader();
      emit(SmartCardState(
          state: SmartCardStateX.success,
          id: idCardResponse.id,
          engName: idCardResponse.engName,
          thaiName: idCardResponse.thaiName,
          birthdate: idCardResponse.birthdate,
          gender: idCardResponse.gender,
          address: idCardResponse.address,
          photoPath: idCardResponse.photoPath,
          photoByte: idCardResponse.photoByte));
    } catch (e) {
      emit(const SmartCardState(
          state: SmartCardStateX.failure,
          id: "",
          engName: "",
          thaiName: "",
          birthdate: "",
          gender: "",
          address: "",
          photoPath: "",
          photoByte: ""));
    }
  }
}
