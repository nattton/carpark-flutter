import 'package:carpark/features/live_player/view_models/live_player_viewmodel.dart';
import 'package:carpark/shared/injector/injector.dart';
import 'package:flutter/material.dart';
import 'package:media_kit_video/media_kit_video.dart';

class LivePlayerWidget extends StatelessWidget {
  const LivePlayerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width / 2 - 60;
    var height = (MediaQuery.of(context).size.width / 2 - 60) * 9.0 / 16.0;

    if ((height * 2) + 100 > MediaQuery.of(context).size.height) {
      height = MediaQuery.of(context).size.height / 2 - 50;
      width = (MediaQuery.of(context).size.width / 2 - 50) * 16.0 / 9.0;
    }
    return Column(
      children: [
        SizedBox(
          width: width,
          height: height,
          child: Video(controller: getIt<LivePlayerViewmodel>().mainController),
        ),
        const SizedBox(height: 4),
        SizedBox(
          width: width,
          height: height,
          child: Video(controller: getIt<LivePlayerViewmodel>().sideController),
        ),
      ],
    );
  }
}
