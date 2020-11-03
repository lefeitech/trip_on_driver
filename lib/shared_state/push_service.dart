import 'package:flutter/material.dart';
import 'dart:async';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:driver/common/config/config.dart';

class PushService with ChangeNotifier {
  static JPush _jpush;

  static Future<void> init() async {
    try {
      _jpush = JPush();
      _jpush.setup(
        appKey: Config.JPUSH_KEY, // 你自己应用的 AppKey
        channel: Config.JPUSH_CHANNEL,
        production: true,
        debug: false,
      );
      _jpush.applyPushAuthority();
    } catch (e) {
      print(e);
    }
  }
}
