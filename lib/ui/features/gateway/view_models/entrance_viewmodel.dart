import 'dart:io';

import 'package:carpark/config/constants.dart';
import 'package:carpark/data/repositories/card_reader/id_card_service_repository.dart';
import 'package:carpark/data/repositories/gate_log/gate_log_repository.dart';
import 'package:carpark/data/repositories/printer/printer_repository.dart';
import 'package:carpark/data/repositories/visitor/visitor_repository.dart';
import 'package:carpark/domain/models/id_card_entity.dart';
import 'package:carpark/domain/models/member_model.dart';
import 'package:carpark/domain/models/visitor_model.dart';
import 'package:carpark/ui/features/home/view_models/last_gate_viewmodel.dart';
import 'package:carpark/ui/features/live_player/view_models/live_player_viewmodel.dart';
import 'package:carpark/utils/result.dart';
import 'package:charset_converter/charset_converter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
import 'package:image/image.dart' as img;
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

class SmartCardReadResult {
  const new({required this.card, this.photoFile});

  final IDCardEntity card;
  final File? photoFile;
}

@injectable
class EntranceViewModel extends ChangeNotifier {
  new({
    required VisitorRepository visitorRepository,
    required GateLogRepository gateLogRepository,
    required IdCardServiceRepository idCardRepository,
    required PrinterRepository printerRepository,
    required LivePlayerViewmodel livePlayerViewModel,
    required LastGateViewmodel lastGateViewModel,
  }) : _visitorRepository = visitorRepository,
       _gateLogRepository = gateLogRepository,
       _idCardRepository = idCardRepository,
       _printerRepository = printerRepository,
       _livePlayerViewModel = livePlayerViewModel,
       _lastGateViewModel = lastGateViewModel;

  final VisitorRepository _visitorRepository;
  final GateLogRepository _gateLogRepository;
  final IdCardServiceRepository _idCardRepository;
  final PrinterRepository _printerRepository;
  final LivePlayerViewmodel _livePlayerViewModel;
  final LastGateViewmodel _lastGateViewModel;

  Future<Result<void>> manualCapture(String door) {
    return _gateLogRepository.manualCapture(door);
  }

  Future<Result<SmartCardReadResult>> readSmartCard() async {
    final cardResult = await _idCardRepository.readIdCard();
    switch (cardResult) {
      case Error<IDCardEntity>():
        return Result.error(cardResult.error);
      case Ok<IDCardEntity>():
        final card = cardResult.value;
        final photoFile = await _tempImage(card.id);
        final downloadResult = await _idCardRepository.downloadPhoto(
          card.photoUrl(),
          photoFile.path,
        );
        final effectivePhotoFile = downloadResult is Ok<void> ? photoFile : null;
        return Result.ok(
          SmartCardReadResult(card: card, photoFile: effectivePhotoFile),
        );
    }
  }

  Future<Result<VisitorModel>> saveAndPrintVisitor({
    required VisitorModel visitor,
    required MemberModel selectedMember,
    File? photoFile,
  }) async {
    final createResult = await _visitorRepository.createVisitor(visitor);
    switch (createResult) {
      case Error<VisitorModel>():
        return Result.error(createResult.error);
      case Ok<VisitorModel>():
        final createdVisitor = createResult.value;
        if (createdVisitor.idCard != '' &&
            photoFile != null &&
            photoFile.existsSync()) {
          await _visitorRepository.addPhotoVisitor(
            createdVisitor.id,
            photoFile,
          );
        }
        await _addImageToVisitor(createdVisitor);
        final ticketBytes = await _generateTicket(
          createdVisitor,
          selectedMember,
        );
        await _printerRepository.printBytes(ticketBytes);
        return Result.ok(createdVisitor);
    }
  }

  Future<void> _addImageToVisitor(VisitorModel visitor) async {
    final cardImage = await _tempImage('card');
    final inSideImage = await _tempImage('in_side');
    final entranceImage = await _tempImage('entrance');

    final cardScreenshot = await _livePlayerViewModel.cardPlayer.screenshot();
    final sideScreenshot = await _livePlayerViewModel.sidePlayer.screenshot();
    final mainScreenshot = await _livePlayerViewModel.mainPlayer.screenshot();

    if (cardScreenshot != null) {
      await cardImage.writeAsBytes(cardScreenshot);
    }
    if (sideScreenshot != null) {
      await inSideImage.writeAsBytes(sideScreenshot);
    }
    if (mainScreenshot != null) {
      await entranceImage.writeAsBytes(mainScreenshot);
    }

    if (cardImage.existsSync()) {
      await _visitorRepository.addImageToVisitor(visitor.id, 'card', cardImage);
      await cardImage.delete();
    }
    if (inSideImage.existsSync()) {
      await _visitorRepository.addImageToVisitor(
        visitor.id,
        'in_side',
        inSideImage,
      );
      await inSideImage.delete();
    }
    if (entranceImage.existsSync()) {
      await _visitorRepository.addImageToVisitor(
        visitor.id,
        'entrance',
        entranceImage,
      );
      await entranceImage.delete();
    }
  }

  Future<Uint8List> _charsetConvert(String s) {
    return CharsetConverter.encode('windows-874', s);
  }

  Future<List<int>> _generateTicket(
    VisitorModel visitor,
    MemberModel? selectedMember,
  ) async {
    final gateLogIn = _lastGateViewModel.gateIn.value;
    var bytes = <int>[];
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile, spaceBetweenRows: 8);
    bytes += generator.setGlobalCodeTable('CP874');

    final data = await rootBundle.load('images/logo.png');
    final imgBytes = data.buffer.asUint8List();
    final image = img.decodeImage(imgBytes)!;
    bytes += generator.image(image);

    bytes += generator.qrcode(visitor.dateTimeNanoShortFormat());

    if (kVehicleTypeMap.containsKey(visitor.type)) {
      final vehicleType = kVehicleTypeMap[visitor.type];
      bytes += generator.textEncoded(
        await _charsetConvert('ประเภท : $vehicleType'),
        styles: const PosStyles(
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),
      );
    }
    bytes += generator.textEncoded(
      await _charsetConvert('ทะเบียนรถ : ${visitor.plateNumber!}'),
      styles: const PosStyles(
        height: PosTextSize.size2,
        width: PosTextSize.size2,
      ),
    );

    bytes += generator.textEncoded(
      await _charsetConvert('วันที่ : ${gateLogIn.dateFormat()}'),
      styles: const PosStyles(
        height: PosTextSize.size2,
        width: PosTextSize.size2,
      ),
    );
    bytes += generator.textEncoded(
      await _charsetConvert('เวลา : ${gateLogIn.timeFormat()}'),
      styles: const PosStyles(
        height: PosTextSize.size2,
        width: PosTextSize.size2,
      ),
    );

    bytes += generator.textEncoded(
      await _charsetConvert('เวลาออก _______________'),
      styles: const PosStyles(
        height: PosTextSize.size2,
        width: PosTextSize.size2,
      ),
      linesAfter: 1,
    );

    if (selectedMember != null) {
      bytes += generator.textEncoded(
        await _charsetConvert('ติดต่อ : ${selectedMember.name}'),
        styles: const PosStyles(
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),
        linesAfter: 1,
      );
    } else {
      bytes += generator.textEncoded(
        await _charsetConvert('ติดต่อ _______________'),
        styles: const PosStyles(
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),
        linesAfter: 1,
      );
    }

    final dataFrame = await rootBundle.load('images/frame_stamp.png');
    final imgFrameBytes = dataFrame.buffer.asUint8List();
    final imageFrame = img.decodeImage(imgFrameBytes)!;
    bytes += generator.image(imageFrame);

    if (visitor.member?.status == 'overdue') {
      bytes += generator.textEncoded(
        await _charsetConvert('*$kOverdueText $kOverdue2Text*'),
        styles: const PosStyles(
          bold: true,
          align: PosAlign.center,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),
        linesAfter: 2,
      );
    }

    bytes += generator.feed(2);
    bytes += generator.cut();
    return bytes;
  }

  Future<File> _tempImage(String type) async {
    final directory = await getTemporaryDirectory();
    return File('${directory.path}/$type.jpg');
  }
}
