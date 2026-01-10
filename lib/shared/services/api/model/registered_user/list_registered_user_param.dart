import 'package:equatable/equatable.dart';

class ListRegisteredUserParam extends Equatable {

  const ListRegisteredUserParam({required this.search});
  final String search;

  @override
  List<Object?> get props => [search];
}
