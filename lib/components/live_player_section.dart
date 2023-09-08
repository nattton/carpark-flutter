import 'package:flutter/material.dart';
import 'package:media_kit_video/media_kit_video.dart';

class LivePlayerSection extends StatelessWidget {
  const LivePlayerSection(
      {super.key, required this.mainController, required this.sideController});

  final VideoController mainController;
  final VideoController sideController;

  @override
  Widget build(BuildContext context) {
    double width =  MediaQuery.of(context).size.width / 2 - 60;
    double height =  ((MediaQuery.of(context).size.width / 2 - 60) *
        9.0 /
        16.0);

    if ((height * 2) + 100 >  MediaQuery.of(context).size.height) {
      height =  (MediaQuery.of(context).size.height / 2 - 50);
      width =  (MediaQuery.of(context).size.width / 2 - 50) * 16.0/9.0;
    }
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          width: width,
          height: height,
          child: Video(
            controller: mainController,
            controls: null,
          ),
        ),
        const SizedBox(
          height: 4.0,
        ),
        SizedBox(
          width: width,
          height: height,
          child: Video(
            controller: sideController,
            controls: null,
          ),
        ),
      ],
    );
  }
}
