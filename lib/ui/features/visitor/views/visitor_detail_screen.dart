import 'package:carpark/config/constants.dart';
import 'package:carpark/config/injector.dart';
import 'package:carpark/ui/features/visitor/view_models/visitor_detail_viewmodel.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:material_ui/material_ui.dart';

class VisitorDetailScreen extends WatchingWidget {
  const new({required this.visitorId, super.key});

  final int visitorId;

  @override
  Widget build(BuildContext context) {
    pushScope(
      init: (di) => di.registerSingleton<VisitorDetailViewModel>(
        getIt<VisitorDetailViewModel>(),
      ),
    );

    callOnce((_) {
      getIt<VisitorDetailViewModel>().getVisitorCommand.run(visitorId);
    });

    registerHandler(
      select: (VisitorDetailViewModel viewModel) =>
          viewModel.getVisitorCommand.isRunning,
      handler: (context, isRunning, _) async {
        if (isRunning) {
          await EasyLoading.show(status: 'loading...');
        } else {
          await EasyLoading.dismiss();
        }
      },
    );

    final visitor = watchValue(
      (VisitorDetailViewModel viewModel) => viewModel.getVisitorCommand,
    );

    return visitor.id > 0
        ? Scaffold(
            appBar: AppBar(
              title: Text('ผู้ติดต่อ เวลาเข้า : ${visitor.dateTimeFormat()}'),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    if (visitor.photoUrl() != '')
                      Image.network(visitor.photoUrl())
                    else
                      const SizedBox(),
                    Text(
                      'เลขประจำตัวประชาชน : ${visitor.idCard!}',
                      style: kContentStyle,
                    ),
                    Text(
                      'ชื่อไทย : ${visitor.thaiName!}',
                      style: kContentStyle,
                    ),
                    Text(
                      'English Name : ${visitor.engName!}',
                      style: kContentStyle,
                    ),
                    Text('เพศ : ${visitor.gender!}', style: kContentStyle),
                    Text(
                      'วันเกิด : ${visitor.birthdate!}',
                      style: kContentStyle,
                    ),
                    Text('ที่อยู่ : ${visitor.address!}', style: kContentStyle),
                    const SizedBox(height: 10),
                    for (final image in visitor.visitorImages!)
                      Image.network(image.imageUrl()),
                    if (visitor.gateLog?.captureImage != null &&
                        visitor.gateLog!.captureImage!.isNotEmpty)
                      Image.network(visitor.gateLog!.captureImageUrl())
                    else
                      const SizedBox(),
                    if (visitor.gateLogOut?.captureImage != null &&
                        visitor.gateLogOut!.captureImage!.isNotEmpty)
                      Image.network(visitor.gateLogOut!.captureImageUrl())
                    else
                      const SizedBox(),
                  ],
                ),
              ),
            ),
          )
        : const SizedBox();
  }
}
