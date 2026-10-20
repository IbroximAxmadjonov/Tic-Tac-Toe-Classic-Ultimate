import 'package:flutter/foundation.dart';

void appDebugPrint({
  required Object e,
  required StackTrace stackTrace,
  required String from,
}) {
  debugPrint('From: $from');
  debugPrint(e.toString());
  debugPrint(stackTrace.toString());
  debugPrint('==========================================');
}
