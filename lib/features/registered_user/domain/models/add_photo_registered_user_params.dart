import 'dart:io';

import 'package:equatable/equatable.dart';

class AddPhotoRegisteredUserParam extends Equatable {
  final int id;
  final File photo;

  const AddPhotoRegisteredUserParam({
    required this.id,
    required this.photo,
  });

  @override
  List<Object?> get props => [id, photo];
}
