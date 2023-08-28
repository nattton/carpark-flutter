import 'package:flutter/material.dart';

const kHostUrl = 'http://localhost:4000';
// const kHostUrl = 'http://192.168.1.50:4000';
// const kHostUrl = 'http://cyptpr.ddns.net';

const kSmartCardReaderUrl = 'http://localhost:3000';

const kMemberTypeList = ['resident', 'carrier', 'subcontractor'];
const kStatusList = ['active', 'inactive', 'overdue'];
const kVehicleTypeMap = {
  'car': 'รถยนต์',
  'taxi': 'แท็กซี่',
  'motorcycle': 'มอเตอร์ไซค์',
};
const kReportTypeMap = {
  'member_traffic': 'รถสมาชิกเข้า-ออก',
  'visitor_traffic': 'รถผู้ติดต่อสมาชิกเข้า-ออก',
};

const kGenderMap = {
  '1': 'ชาย',
  '2': 'หญิง',
};

const kDefaultFont = 'NotoSerif';
const kBoldFont = 'NotoSerif-Bold';
const kColorTop = Color(0xFF009CDE);
const kColorBottom = Color(0xFF003C71);
const kColorTextGrey = Color(0xFF707070);
const kColorTextBlack = Color.fromARGB(255, 0, 0, 0);
const kBackgroundGradiant = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [kColorTop, kColorBottom],
);

const kGateStyle = TextStyle(
    color: kColorTextBlack,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    fontFamily: kDefaultFont,
    height: 2);

const kHeaderStyle = TextStyle(
    color: kColorTextGrey,
    fontSize: 15,
    fontWeight: FontWeight.bold,
    fontFamily: kDefaultFont);
const kContentStyleHeader = TextStyle(
    color: Color(0xff999999),
    fontSize: 14,
    fontWeight: FontWeight.w700,
    fontFamily: kDefaultFont);
const kContentStyle = TextStyle(
    color: kColorTextBlack,
    fontSize: 18,
    fontWeight: FontWeight.normal,
    fontFamily: kDefaultFont);

const kButtonStyle = TextStyle(
    color: kColorTextBlack,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    fontFamily: kDefaultFont,
    height: 2);
const kButton2Style = TextStyle(
    color: kColorTop,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    fontFamily: kDefaultFont,
    height: 2);

const kOverdueTextStyle = TextStyle(
    color: Color.fromARGB(255, 255, 0, 0),
    fontSize: 30,
    fontWeight: FontWeight.bold,
    fontFamily: kDefaultFont,
    height: 2);

const kColorOpened = Color(0xFFE5E5E5);
const kImageEvent = Image(image: AssetImage('images/event.jpg'));

const kDialogTextStyle = TextStyle(
  fontFamily: kDefaultFont,
  fontSize: 16.0,
  color: kColorTextGrey,
);

const kDialogTitleStyle = TextStyle(
  fontFamily: kDefaultFont,
  fontSize: 16.0,
  fontWeight: FontWeight.bold,
  color: kColorTextGrey,
);

const kIconPin = Icon(
  Icons.pin_drop,
  size: 16.0,
  color: Colors.teal,
);

const kSpaceTextEvent = SizedBox(
  height: 8.0,
);
const kOverdueText = 'ค้างชำระค่าส่วนกลาง';
const kOverdue2Text = 'กรุณาติดต่อนิติบุคคล';

const kColorVisitor = Color.fromARGB(255, 223, 45, 0);
const kColorResident = Color.fromARGB(255, 105, 240, 174);
const kColorOverdue = Color.fromARGB(255, 183, 31, 230);
