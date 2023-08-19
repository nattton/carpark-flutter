import 'package:cached_network_image/cached_network_image.dart';
import 'package:carpark/models/visitor_model.dart';
import 'package:flutter/material.dart';
import 'package:carpark/constants.dart';
import 'package:qr_flutter/qr_flutter.dart';

class VisitorListCard extends StatelessWidget {
  const VisitorListCard(
      {super.key, required this.visitor, required this.onTap});

  final VisitorModel visitor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: visitor.id == 0
          ? Card(
              color: Colors.blue.shade200,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "วันที่ เวลา เข้า",
                        style: TextStyle(
                            fontFamily: kDefaultFont,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "วันที่ เวลา ออก",
                        style: TextStyle(
                            fontFamily: kDefaultFont,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "ทะเบียน",
                        style: TextStyle(
                          fontFamily: kDefaultFont,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "ติดต่อ",
                        style: TextStyle(
                          fontFamily: kDefaultFont,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "ชื่อ",
                        style: TextStyle(
                          fontFamily: kDefaultFont,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        visitor.dateTimeFormat(),
                        style: const TextStyle(
                            fontFamily: kDefaultFont,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    visitor.exitTime!.valid!
                        ? Expanded(
                            child: Text(
                              visitor.exitDateTimeFormat(),
                              style: const TextStyle(
                                  fontFamily: kDefaultFont,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        : Expanded(
                            child: QrImageView(
                              data: visitor.dateTimeNanoShortFormat(),
                              version: QrVersions.auto,
                              size: 60,
                              gapless: false,
                            ),
                          ),
                    Expanded(
                      child: Text(
                        visitor.plateNumber!,
                        style: const TextStyle(
                          fontFamily: kDefaultFont,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        visitor.member!.name!,
                        style: const TextStyle(
                          fontFamily: kDefaultFont,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        visitor.thaiName!,
                        style: const TextStyle(
                          fontFamily: kDefaultFont,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
