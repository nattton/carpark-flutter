import 'package:cached_network_image/cached_network_image.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:carpark/components/visitor_list_card.dart';
import 'package:carpark/constants.dart';
import 'package:carpark/injection_container.dart';
import 'package:carpark/models/visitor_model.dart';
import 'package:carpark/services/api_service.dart';
import 'package:carpark/services/app_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class VisitorScreen extends StatefulWidget {
  const VisitorScreen({super.key});

  @override
  State<VisitorScreen> createState() => _VisitorScreenState();
}

class _VisitorScreenState extends State<VisitorScreen> {
  List<DateTime?> _dates = [DateTime.now()];

  List<VisitorModel> visitorList = [];
  List<VisitorModel> searchVisitorList = [];

  final _searchController = TextEditingController();

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        getVisitorList(newSelectedDate);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    _selectDate(DateTime(now.year, now.month, now.day));
  }

  onSearchTextChanged(String text) async {
    if (text.isEmpty) {
      setState(() {
        searchVisitorList = visitorList;
      });
    } else {
      setState(() {
        searchVisitorList = visitorList
            .where((visitor) => (visitor.plateNumber!.contains(text) ||
                visitor.member!.name!.contains(text) ||
                visitor.thaiName!.contains(text)))
            .toList();
      });
    }
  }

  Future<void> getVisitorList(DateTime selectedDate) async {
    var date = DateFormat('yyyy-MM-dd').format(selectedDate);
    sl<ApiService>().listVisitor(sl<AppService>().token, date).then((value) {
      setState(() {
        visitorList = value;
        searchVisitorList.clear();
        if (_searchController.text.isEmpty) {
          searchVisitorList = visitorList;
        } else {
          onSearchTextChanged(_searchController.text);
        }
      });
    }).catchError((error) {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10.0,
        ),
        Row(
          children: [
            OutlinedButton(
              onPressed: () async {
                var results = await showCalendarDatePicker2Dialog(
                  context: context,
                  config: CalendarDatePicker2WithActionButtonsConfig(),
                  dialogSize: const Size(325, 400),
                  value: _dates,
                  borderRadius: BorderRadius.circular(15),
                );

                if (results != null) {
                  setState(() {
                    _selectDate(results[0]);
                    _dates = results;
                  });
                }
              },
              child: Text(
                  'เลือกวันที่ : ${_dates[0]!.day}/${_dates[0]!.month}/${_dates[0]!.year}'),
            ),
            const SizedBox(
              width: 10.0,
            ),
            OutlinedButton(
              onPressed: () {
                _selectDate(_dates[0]);
              },
              child: const Text('Refresh'),
            ),
          ],
        ),
        ListTile(
          leading: const Icon(Icons.search),
          title: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
                hintText: 'Search', border: InputBorder.none),
            onChanged: onSearchTextChanged,
          ),
          trailing: IconButton(
            icon: const Icon(Icons.cancel),
            onPressed: () {
              _searchController.clear();
              onSearchTextChanged('');
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: searchVisitorList.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return VisitorListCard(
                  visitor: VisitorModel.empty(),
                  onTap: () {},
                );
              }
              return VisitorListCard(
                  visitor: searchVisitorList[index - 1],
                  onTap: () => viewDetail(searchVisitorList[index - 1]));
            },
          ),
        )
      ],
    );
  }

  void viewDetail(VisitorModel visitor) {
    Alert(
      context: context,
      title: "ผู้ติดต่อ เวลาเข้า : ${visitor.dateTimeFormat()}",
      content: Column(
        children: <Widget>[
          Text("เลขประจำตัวประชาชน : ${visitor.idCard!}"),
          Text("ชื่อ : ${visitor.thaiName!}"),
          Text("ที่อยู่ : ${visitor.address!}"),
          const SizedBox(
            height: 10.0,
          ),
          for (var image in visitor.visitorImages!)
            Image.network("$kHostUrl/anpr_store/${image.image}"),
          visitor.gateLog!.captureImage! != ""
              ? CachedNetworkImage(
                  imageUrl:
                      "$kHostUrl/anpr_store/${visitor.gateLog!.captureImage!}",
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )
              : const SizedBox(),
        ],
      ),
    ).show();
  }
}
