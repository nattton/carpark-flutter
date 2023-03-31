import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:carpark/screens/my_app.dart';

void main() {
  DartVLC.initialize();
  runApp(const MyApp());
}
