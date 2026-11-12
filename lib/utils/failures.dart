import 'dart:convert';

import 'package:dio/dio.dart';

class Failure implements Exception {
  new([this.message = 'An unexpected error occurred,']);

  factory fromException(Object e) {
    if (e is Failure) {
      return e;
    }
    if (e is DioException) {
      final data = e.response?.data;
      if (data is Map<String, dynamic> && data['message'] is String) {
        return Failure(data['message'] as String);
      }
      return Failure(e.message ?? e.toString());
    }
    return Failure(e.toString());
  }

  factory fromMap(Map<String, dynamic> map) {
    return Failure(map['message'] as String);
  }

  factory fromJson(String source) =>
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
