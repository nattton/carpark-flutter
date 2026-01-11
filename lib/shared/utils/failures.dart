import 'dart:convert';

import 'package:dio/dio.dart';

class Failure implements Exception {
  Failure([this.message = 'An unexpected error occurred,']);
  Failure.fromException(Object e)
    : message = (e is DioException)
          ? e.response?.data['message'] as String? ?? e.toString()
          : e.toString();

  factory Failure.fromMap(Map<String, dynamic> map) {
    return Failure(map['message'] as String);
  }

  factory Failure.fromJson(String source) =>
      Failure.fromMap(json.decode(source) as Map<String, dynamic>);
  final String message;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'message': message};
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return message;
  }
}
