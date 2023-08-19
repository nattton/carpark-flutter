import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:carpark/components/gate_log_card.dart';
import 'package:carpark/constants.dart';
import 'package:carpark/injection_container.dart';
import 'package:carpark/models/gate_log_model.dart';
import 'package:carpark/services/api_service.dart';
import 'package:carpark/services/app_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class GateLogScreen extends StatefulWidget {
  const GateLogScreen({super.key});

  @override
  State<GateLogScreen> createState() => _GateLogScreenState();
}

class _GateLogScreenState extends State<GateLogScreen> {
  List<DateTime?> _dates = [DateTime.now()];

  List<GateLogModel> gateLogList = [];
  List<GateLogModel> searchGateLogList = [];

  final _searchController = TextEditingController();

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        getGateLogList(newSelectedDate);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    _selectDate(DateTime(now.year, now.month, now.day));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  onSearchTextChanged(String text) async {
    if (text.isEmpty) {
      setState(() {
        searchGateLogList = gateLogList;
      });
    } else {
      setState(() {
        searchGateLogList = gateLogList
            .where((gateLog) => (gateLog.plateNumber!.contains(text) ||
                gateLog.member!.name!.contains(text)))
            .toList();
      });
    }
  }

  Future<void> getGateLogList(DateTime selectedDate) async {
    var date = DateFormat('yyyy-MM-dd').format(selectedDate);
    sl<ApiService>().searchGateLog(sl<AppService>().token, date).then((value) {
      setState(() {
        gateLogList = value;
        searchGateLogList.clear();
        if (_searchController.text.isEmpty) {
          for (GateLogModel gateLog in gateLogList) {
            searchGateLogList.add(gateLog);
          }
        } else {
          onSearchTextChanged(_searchController.text);
        }
      });
    }).onError((error, stackTrace) {
      alertError(error.toString());
    });
  }

  void alertError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            autofocus: false,
            autocorrect: false,
            onChanged: onSearchTextChanged,
            decoration: InputDecoration(
              labelText: 'Search',
              suffixIcon: GestureDetector(
                onTap: () {
                  _searchController.clear();
                  onSearchTextChanged('');
                },
                child: const Icon(Icons.clear),
              ),
              contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: searchGateLogList.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return GateLogCard(
                  gateLog: GateLogModel(0),
                  onTap: () {},
                );
              }
              return GateLogCard(
                  gateLog: searchGateLogList[index - 1],
                  onTap: () => viewDetail(searchGateLogList[index - 1]));
            },
          ),
        )
      ],
    );
  }

  void viewDetail(GateLogModel gateLog) {
    Alert(
      context: context,
      title: "Gate Log",
      content: Column(
        children: <Widget>[
          Image.network("$kHostUrl/anpr_store/${gateLog.captureImage!}"),
        ],
      ),
    ).show();
  }
}
