import 'dart:io';

import 'package:equatable/equatable.dart';

class AddPhotoRegisteredUserParam extends Equatable {

  const AddPhotoRegisteredUserParam({required this.id, required this.photo});
  final int id;
  final File photo;

  @override
  List<Object?> get props => [id, photo];
}
