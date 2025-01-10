part of 'id_card_bloc.dart';

sealed class IdCardState extends Equatable {
  const IdCardState();
  
  @override
  List<Object> get props => [];
}

final class IdCardInitial extends IdCardState {}
