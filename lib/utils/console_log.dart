import 'dart:async';
import 'dart:developer';
import 'package:flutter/foundation.dart';

void consoleLog(
  String message, {
  DateTime? time,
  int? sequenceNumber,
  int level = 0,
  Zone? zone,
  Object? error,
  StackTrace? stackTrace,
}) {
  if (kDebugMode) {
    log(
      message,
      time: time,
      sequenceNumber: sequenceNumber,
      level: level,
      name: "ECOM",
      zone: zone,
      error: error,
      stackTrace: stackTrace,
    );
  }
}

