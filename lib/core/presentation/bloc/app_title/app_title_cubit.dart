import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'app_title_state.dart';

@Injectable()
class AppTitleCubit extends Cubit<AppTitleState> {
  AppTitleCubit() : super(const AppTitleInitial());

  void changeTitle(String title) {
    emit(AppTitleChange(title));
  }
}
