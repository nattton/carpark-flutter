// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int? id;
  final String? username;
  final String? role;

  const UserEntity({
    this.id,
    this.username,
    this.role,
  });

  @override
  List<Object?> get props => [id, username, role];
}
