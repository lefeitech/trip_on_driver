import 'package:driver/common/utils/common_util.dart';
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

  static Future<void> setAlias(String alias) async {
    try {
      final res = await _jpush.setAlias(alias);
      if (res['errorCode'] != null && Config.debugMode) {
        CommonUtils.showMessage('设置用户别名失败');
      }
    } catch (e) {}
  }

  static Future<void> setTags(List<String> tags) async {
    try {
      final res = await _jpush.setTags(tags);
      if (res['errorCode'] != null && Config.debugMode) {
        CommonUtils.showMessage('设置用户标签失败');
      }
    } catch (e) {}
  }
}
