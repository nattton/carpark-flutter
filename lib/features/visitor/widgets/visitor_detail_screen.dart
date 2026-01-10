import 'package:carpark/shared/config/constants.dart';
import 'package:carpark/shared/injector/injector.dart';
import 'package:carpark/shared/models/visitor_model.dart';
import 'package:carpark/shared/services/api/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class VisitorDetailScreen extends StatefulWidget {
  const VisitorDetailScreen({required this.visitorId, super.key});

  final int visitorId;
  @override
  State<VisitorDetailScreen> createState() => _VisitorDetailScreenState();
}

class _VisitorDetailScreenState extends State<VisitorDetailScreen> {
  int get visitorId => widget.visitorId;

  VisitorModel visitor = VisitorModel(0);

  @override
  void initState() {
    super.initState();
    getVisitor();
  }

  @override
  Widget build(BuildContext context) {
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
                    if (visitor.gateLog!.captureImage! != '')
                      Image.network(visitor.gateLog!.captureImageUrl())
                    else
                      const SizedBox(),
                    if (visitor.gateLogOut!.captureImage! != '')
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

  void getVisitor() {
    EasyLoading.show(status: 'loading...');
    getIt<ApiService>()
        .getVisitor(visitorId)
        .then((value) {
          setState(() {
            visitor = value;
          });
        })
        .whenComplete(EasyLoading.dismiss);
  }
}
