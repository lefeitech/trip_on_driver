import 'dart:convert' show json;
import 'push_event.dart';

class AndroidEventModal {
  String alert;
  Extras extras;
  String title;

  AndroidEventModal({
    this.alert,
    this.extras,
    this.title,
  });

  factory AndroidEventModal.fromJson(jsonRes) => jsonRes == null
      ? null
      : AndroidEventModal(
    alert: jsonRes['alert'],
    extras: Extras.fromJson(jsonRes['extras']),
    title: jsonRes['title'],
  );

  Map<String, dynamic> toJson() => {
    'alert': alert,
    'extras': extras,
    'title': title,
  };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Extras {
  String app;
  String alertType;
  int notificationId;
  String msgId;
  String notificationType;
  String alert;
  MessageContent extra;
  String sdkType;

  Extras({
    this.app,
    this.alertType,
    this.notificationId,
    this.msgId,
    this.notificationType,
    this.alert,
    this.extra,
    this.sdkType,
  });

  factory Extras.fromJson(jsonRes) {
    if (jsonRes != null) {
      return Extras(
        app: jsonRes['app'],
        alertType: jsonRes['cn.jpush.android.ALERT_TYPE'],
        notificationId: jsonRes['cn.jpush.android.NOTIFICATION_ID'],
        msgId: jsonRes['cn.jpush.android.MSG_ID'],
        notificationType: jsonRes['cn.jpush.android.NOTIFICATION_TYPE'],
        alert: jsonRes['cn.jpush.android.ALERT'],
        extra: MessageContent.fromJson(
            json.decode(jsonRes['cn.jpush.android.EXTRA'])),
        sdkType: jsonRes['sdkType'],
      );
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    return {
      'app': app,
      'cn.jpush.android.ALERT_TYPE': alertType,
      'cn.jpush.android.NOTIFICATION_ID': notificationId,
      'cn.jpush.android.MSG_ID': msgId,
      'cn.jpush.android.NOTIFICATION_TYPE': notificationType,
      'cn.jpush.android.ALERT': alert,
      'cn.jpush.android.EXTRA': extra,
      'sdkType': sdkType,
    };
  }

  @override
  String toString() {
    return json.encode(this);
  }
}
