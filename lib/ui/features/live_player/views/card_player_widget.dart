import 'package:carpark/config/injector.dart';
import 'package:carpark/ui/features/live_player/view_models/live_player_viewmodel.dart';
import 'package:material_ui/material_ui.dart';
import 'package:media_kit_video/media_kit_video.dart';

class CardPlayerWidget extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2 - 60,
      height: (MediaQuery.of(context).size.width / 2 - 60) * 9.0 / 16.0,
      child: Video(
        controller: getIt<LivePlayerViewmodel>().cardController,
        controls: null,
      ),
    );
  }
}
