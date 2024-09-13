import 'package:cached_network_image/cached_network_image.dart';
import 'package:carpark/constants.dart';
import 'package:carpark/injection_container.dart';
import 'package:carpark/models/visitor_model.dart';
import 'package:carpark/services/api_service.dart';
import 'package:carpark/services/app_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class VisitorDetailScreen extends StatefulWidget {
  static const id = "visitor_detail_screen";
  const VisitorDetailScreen({super.key, required this.visitorId});

  final int visitorId;
  @override
  State<VisitorDetailScreen> createState() => _VisitorDetailScreenState();
}

class _VisitorDetailScreenState extends State<VisitorDetailScreen> {
  get visitorId => widget.visitorId;

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
                    visitor.photoUrl().isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: visitor.photoUrl(),
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          )
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
                    Text(
                      "เพศ : ${visitor.gender!}",
                      style: kContentStyle,
                    ),
                    Text(
                      "วันเกิด : ${visitor.birthdate!}",
                      style: kContentStyle,
                    ),
                    Text(
                      "ที่อยู่ : ${visitor.address!}",
                      style: kContentStyle,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    for (var image in visitor.visitorImages!)
                      CachedNetworkImage(
                        imageUrl: image.imageUrl(),
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    visitor.gateLog!.captureImage!.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: visitor.gateLog!.captureImage!,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          )
                        : const SizedBox(),
                    visitor.gateLogOut!.captureImage!.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: visitor.gateLogOut!.captureImage!,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          )
        : const SizedBox();
  }

  getVisitor() {
    EasyLoading.show(status: 'loading...');
    sl<ApiService>()
        .getVisitor(sl<AppService>().token, visitorId)
        .then((value) {
      setState(() {
        visitor = value;
      });
    }).whenComplete(() => EasyLoading.dismiss());
  }
}
