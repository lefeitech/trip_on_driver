import 'dart:convert';
import 'dart:io';

import 'package:driver/common/model/push/android_event.dart';
import 'package:driver/common/model/push/ios_event.dart';
import 'package:driver/common/model/push/push_event.dart';
import 'package:driver/common/utils/common_util.dart';
import 'package:driver/common/utils/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:driver/common/config/config.dart';

typedef Future<dynamic> OnPushMessage(PushEventModal event);

class PushService with ChangeNotifier {
  static JPush _jpush;

  Map<String, OnPushMessage> _recieveEvents = {};
  Map<String, OnPushMessage> _openEvents = {};

  static Future<void> init() async {
    try {
      _jpush = JPush();
      _jpush.setup(
        appKey: Config.JPUSH_KEY,
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

  void addEventHandler() {
    _jpush.addEventHandler(
      onReceiveMessage: _onReceiveMessage,
      onOpenNotification: _onOpenNotification,
    );
  }

  void addReceiveEvent({String name, OnPushMessage onPushMessage}) {
    _addEvent(name: name, event: onPushMessage, target: _recieveEvents);
  }

  void addOpenEvent({String name, OnPushMessage onPushMessage}) {
    _addEvent(name: name, event: onPushMessage, target: _openEvents);
  }

  void removeReceiveEvent(String name) {
    _removeEvent(name: name, target: _recieveEvents);
  }

  void removeOpenEvent(String name) {
    _removeEvent(name: name, target: _openEvents);
  }

  Future<dynamic> _onOpenNotification(Map<String, dynamic> data) async {
    if (data == null) return;

    final event = _parseMessage(data);

    if (event == null) return;
    _jpush.clearNotification(notificationId: event.notificationId);
    _jpush.setBadge(0);

    _openEvents.forEach((key, handler) {
      try {
        handler(event);
      } catch (e) {
        print(e);
      }
    });
  }

  Future<dynamic> _onReceiveMessage(Map<String, dynamic> data) async {
    if (data == null) return;

    final event = _parseMessage(data);

    _jpush.clearAllNotifications();
    _jpush.setBadge(0);

    _recieveEvents.forEach((key, handler) {
      handler(event);
    });
  }

  PushEventModal _parseMessage(Map<String, dynamic> message) {
    if (Platform.isAndroid) {
      final data = AndroidEventModal.fromJson(message);
      return PushEventModal<AndroidEventModal>.fromAndroid(data);
    }

    if (Platform.isIOS) {
      final data = IOSEventModel.fromJson(message);
      return PushEventModal<IOSEventModel>.fromIos(data);
    }
    return null;
  }

  void _addEvent({
    String name,
    OnPushMessage event,
    Map<String, OnPushMessage> target,
  }) {
    if (target.containsKey(name)) {
      print('event exist, this operation will cover old event: $name');
    }
    target[name] = event;
  }

  void _removeEvent({String name, Map<String, OnPushMessage> target}) {
    target.remove(name);
  }

  @override
  void dispose() {
    super.dispose();
    _openEvents.clear();
    _recieveEvents.clear();
  }
}
