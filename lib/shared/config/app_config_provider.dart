import 'package:carpark/shared/config/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:universal_html/html.dart' as html;

class AppConfigProvider {
  String? getCurrentHost() {
    final kCurrentHost = kIsWeb ? html.window.location.origin : kHostUrl;
    return kCurrentHost;
  }
}
