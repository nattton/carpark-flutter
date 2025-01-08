part of 'app_title_cubit.dart';

sealed class AppTitleState extends Equatable {
  final String title;
  const AppTitleState(this.title);

  @override
  List<Object> get props => [title];
}

final class AppTitleInitial extends AppTitleState {
  const AppTitleInitial() : super('Car Park');
}

final class AppTitleChange extends AppTitleState {
  const AppTitleChange(super.title);
}
