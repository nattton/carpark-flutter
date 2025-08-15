// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dio/dio.dart';

class Failure {
  final String message;
  Failure([this.message = 'An unexpected error occurred,']);
  Failure.fromException(Object e)
    : message = (e is DioException)
          ? e.response?.data['message'] ?? e.toString()
          : e.toString();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'message': message};
  }

  factory Failure.fromMap(Map<String, dynamic> map) {
    return Failure(map['message'] as String);
  }

  String toJson() => json.encode(toMap());

  factory Failure.fromJson(String source) =>
      Failure.fromMap(json.decode(source) as Map<String, dynamic>);
}
