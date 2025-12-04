import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:web/web.dart';

Future<void> downloadFile(String logs, {required Rect? sharePositionOrigin}) async {
  // ignore: invalid_runtime_check_with_js_interop_types
  final jsArray = JSArray.from<JSString>(logs.toJS as JSObject);
  final blob = Blob(jsArray, BlobPropertyBag(type: 'text/plain'));

  final fmtDate = DateTime.now().toString().replaceAll(':', ' ');

  final anchor = HTMLAnchorElement()
    ..href = URL.createObjectURL(blob)
    ..download = 'talker_logs_$fmtDate.txt'
    ..click()
    ..remove();

  URL.revokeObjectURL(anchor.href);
}
