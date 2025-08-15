import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../constants.dart';
import '../data/services/api_service.dart';
import '../injector/injector.dart';
import '../models/visitor_model.dart';
import '../services/app_service.dart';

class VisitorDetailScreen extends StatefulWidget {
  static const routeName = "/visitor_detail";
  const VisitorDetailScreen({super.key, required this.visitorId});

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
              title: Text("ผู้ติดต่อ เวลาเข้า : ${visitor.dateTimeFormat()}"),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    visitor.photoUrl() != ""
                        ? Image.network(visitor.photoUrl())
                        : const SizedBox(),
                    Text(
                      "เลขประจำตัวประชาชน : ${visitor.idCard!}",
                      style: kContentStyle,
                    ),
                    Text(
                      "ชื่อไทย : ${visitor.thaiName!}",
                      style: kContentStyle,
                    ),
                    Text(
                      "English Name : ${visitor.engName!}",
                      style: kContentStyle,
                    ),
                    Text("เพศ : ${visitor.gender!}", style: kContentStyle),
                    Text(
                      "วันเกิด : ${visitor.birthdate!}",
                      style: kContentStyle,
                    ),
                    Text("ที่อยู่ : ${visitor.address!}", style: kContentStyle),
                    const SizedBox(height: 10.0),
                    for (final image in visitor.visitorImages!)
                      Image.network(image.imageUrl()),
                    visitor.gateLog!.captureImage! != ""
                        ? Image.network(visitor.gateLog!.captureImageUrl())
                        : const SizedBox(),
                    visitor.gateLogOut!.captureImage! != ""
                        ? Image.network(visitor.gateLogOut!.captureImageUrl())
                        : const SizedBox(),
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
        .getVisitor(getIt<AppService>().token, visitorId)
        .then((value) {
          setState(() {
            visitor = value;
          });
        })
        .whenComplete(() => EasyLoading.dismiss());
  }
}
