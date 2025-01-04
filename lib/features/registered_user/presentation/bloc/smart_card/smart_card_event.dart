part of 'smart_card_bloc.dart';

sealed class SmartCardEvent extends Equatable {
  const SmartCardEvent();

  @override
  List<Object> get props => [];
}

class ReadSmartCard extends SmartCardEvent {}
