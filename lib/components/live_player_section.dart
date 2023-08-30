import 'package:flutter/material.dart';
import 'package:media_kit_video/media_kit_video.dart';

class LivePlayerSection extends StatelessWidget {
  const LivePlayerSection(
      {super.key, required this.mainController, required this.sideController});

  final VideoController mainController;
  final VideoController sideController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 2 - 60,
          height: ((MediaQuery.of(context).size.width / 2 - 60) * 9.0 / 16.0),
          child: Video(
            controller: mainController,
            controls: null,
          ),
        ),
        const SizedBox(
          height: 4.0,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 2 - 60,
          height: ((MediaQuery.of(context).size.width / 2 - 60) * 9.0 / 16.0),
          child: Video(
            controller: sideController,
            controls: null,
          ),
        ),
      ],
    );
  }
}
