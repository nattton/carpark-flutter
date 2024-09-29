import 'package:carpark/components/entrance_display.dart';
import 'package:carpark/features/main/presention/pages/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DisplayScreen extends HookConsumerWidget {
  static const String id = "display_screen";
  static const int gateIn = 0;
  static const int gateOut = 1;
  const DisplayScreen({super.key, required this.screenId});
  final int screenId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    switch (screenId) {
      case gateIn:
        return _buildEntranceView(ref);
      case gateOut:
        return _buildExitView(ref);
      default:
    }
    return AppBar();
  }

  Widget _buildEntranceView(WidgetRef ref) {
    final gateLog = ref.watch(lastGateProvider).gateIn;
    return EntranceDisplay(title: "ทางเข้า", gateLog: gateLog);
  }

  Widget _buildExitView(WidgetRef ref) {
    final gateLog = ref.watch(lastGateProvider).gateOut;
    return EntranceDisplay(title: "ทางออก", gateLog: gateLog);
  }
}
