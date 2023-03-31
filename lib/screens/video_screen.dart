import 'package:carpark/models/gate_log.dart';
import 'package:carpark/services/app_service.dart';
import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late AppService appService;
  var loadLast = false;
  late LastGateLog lastGateLog;
  Player player = Player(
    id: 0,
  );
  Player player2 = Player(
    id: 1,
  );
  MediaType mediaType = MediaType.file;
  CurrentState current = CurrentState();
  PositionState position = PositionState();
  PlaybackState playback = PlaybackState();
  GeneralState general = GeneralState();
  VideoDimensions videoDimensions = const VideoDimensions(0, 0);
  List<Media> medias = <Media>[];
  List<Device> devices = <Device>[];
  TextEditingController controller = TextEditingController();
  TextEditingController metasController = TextEditingController();
  double bufferingProgress = 0.0;
  Media? metadataCurrentMedia;

  @override
  void initState() {
    super.initState();
    AppService.getInstance().then((value) {
      appService = value;
      getLastGateLog();
    });

    if (mounted) {
      player.currentStream.listen((value) {
        setState(() => current = value);
      });
      player.positionStream.listen((value) {
        setState(() => position = value);
      });
      player.playbackStream.listen((value) {
        setState(() => playback = value);
      });
      player.generalStream.listen((value) {
        setState(() => general = value);
      });
      player.videoDimensionsStream.listen((value) {
        setState(() => videoDimensions = value);
      });
      player.bufferingProgressStream.listen(
        (value) {
          setState(() => bufferingProgress = value);
        },
      );
      player.errorStream.listen((event) {
        debugPrint('libVLC error.');
      });
      devices = Devices.all;
      Equalizer equalizer = Equalizer.createMode(EqualizerMode.live);
      equalizer.setPreAmp(10.0);
      equalizer.setBandAmp(31.25, 10.0);
      player.setEqualizer(equalizer);
      player.setVolume(0);

      // rtsp://admin:123456@cyptpr.ddns.net
      // rtsp://tapoadmin:Gundam88@192.168.50.92/stream1
      // rtsp://tapoadmin:Gundam88@192.168.50.99/stream1

      player.open(
        Playlist(
          medias: [
            Media.network('rtsp://admin:123456@cyptpr.ddns.net'),
          ],
        ),
      );

      player2.setVolume(0);
      player2.open(
        Playlist(
          medias: [
            Media.network('rtsp://admin:123456@cyptpr.ddns.net'),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isPhone;
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final width = MediaQuery.of(context).size.width - 80;
    final height = MediaQuery.of(context).size.height;
    final videoW = width / 2;
    final videoH = videoW * 9 / 16;
    if (devicePixelRatio < 2 && (width >= 1000 || height >= 1000)) {
      isPhone = false;
    } else if (devicePixelRatio == 2 && (width >= 1920 || height >= 1920)) {
      isPhone = false;
    } else {
      isPhone = true;
    }
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(4.0),
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4.0,
              clipBehavior: Clip.antiAlias,
              child: Video(
                player: player,
                width: videoW,
                height: videoH,
                volumeThumbColor: Colors.blue,
                volumeActiveColor: Colors.blue,
                showControls: !isPhone,
              ),
            ),
            Card(
              elevation: 4.0,
              clipBehavior: Clip.antiAlias,
              child: Video(
                player: player2,
                width: videoW,
                height: videoH,
                volumeThumbColor: Colors.blue,
                volumeActiveColor: Colors.blue,
                showControls: !isPhone,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 40.0,
        ),
        loadLast
            ? Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Text("Gate In"),
                        Text(
                            "Plate Number : ${lastGateLog.gateIn!.plateNumber!}"),
                        Text(
                            "Member Name : ${lastGateLog.gateIn!.memberName!}"),
                        Text(
                            "Member Type : ${lastGateLog.gateIn!.memberType!}"),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Text("Gate Out"),
                        Text(
                            "Plate Number : ${lastGateLog.gateOut!.plateNumber!}"),
                        Text(
                            "Member Name : ${lastGateLog.gateOut!.memberName!}"),
                        Text(
                            "Member Type :${lastGateLog.gateOut!.memberType!}"),
                      ],
                    ),
                  ),
                ],
              )
            : Container()
      ],
    );
  }

  Future<void> getLastGateLog() async {
    appService.fetchLastGateLog().then((value) {
      setState(() {
        lastGateLog = value;
        loadLast = true;
      });
    }).catchError((error) {});
  }
}
