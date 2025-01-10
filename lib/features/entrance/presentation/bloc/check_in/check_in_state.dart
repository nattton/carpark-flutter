part of 'check_in_bloc.dart';

sealed class CheckInState extends Equatable {
  const CheckInState();
  
  @override
  List<Object> get props => [];
}

final class CheckInInitial extends CheckInState {}
