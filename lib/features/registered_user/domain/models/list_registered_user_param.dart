import 'package:equatable/equatable.dart';

class ListRegisteredUserParam extends Equatable {
  final String search;

  const ListRegisteredUserParam({required this.search});

  @override
  List<Object?> get props => [search];
}
