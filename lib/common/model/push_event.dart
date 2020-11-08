import 'dart:convert' show json;
import 'order/rob_list_res.dart';
import 'dart:io' show Platform;

T asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }

  return null;
}

class PushEventModal {
  String alert;
  Extras extras;
  String title;

  PushEventModal({
    this.alert,
    this.extras,
    this.title,
  });

  factory PushEventModal.fromJson(jsonRes) => jsonRes == null
      ? null
      : PushEventModal(
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
      String platform = Platform.isAndroid ? 'android' : 'ios';
      return Extras(
        app: jsonRes['app'],
        alertType: jsonRes['cn.jpush.$platform.ALERT_TYPE'],
        notificationId: jsonRes['cn.jpush.$platform.NOTIFICATION_ID'],
        msgId: jsonRes['cn.jpush.$platform.MSG_ID'],
        notificationType: jsonRes['cn.jpush.$platform.NOTIFICATION_TYPE'],
        alert: jsonRes['cn.jpush.$platform.ALERT'],
        extra: MessageContent.fromJson(
            json.decode(jsonRes['cn.jpush.$platform.EXTRA'])),
        sdkType: jsonRes['sdkType'],
      );
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    String platform = Platform.isAndroid ? 'android' : 'ios';
    return {
      'app': app,
      'cn.jpush.$platform.ALERT_TYPE': alertType,
      'cn.jpush.$platform.NOTIFICATION_ID': notificationId,
      'cn.jpush.$platform.MSG_ID': msgId,
      'cn.jpush.$platform.NOTIFICATION_TYPE': notificationType,
      'cn.jpush.$platform.ALERT': alert,
      'cn.jpush.$platform.EXTRA': extra,
      'sdkType': sdkType,
    };
  }

  @override
  String toString() {
    return json.encode(this);
  }
}

class MessageContent {
  MessageContent({this.type, this.content});

  String type;
  dynamic content;

  factory MessageContent.fromJson(Map<String, dynamic> jsonRes) {
    if (jsonRes == null) {
      return null;
    }
    MessageContent message = MessageContent();
    final type = asT<String>(jsonRes['type']);
    message.type = type;

    if (jsonRes['content'] == null) {
      return message;
    }
    if (type == 'rob') {
      final List<RobInfo> info =
          jsonRes['content'] is List ? <RobInfo>[] : null;
      if (info != null) {
        for (final dynamic item in jsonRes['content']) {
          if (item != null) {
            info.add(RobInfo.fromJson(asT<Map<String, dynamic>>(item)));
          }
        }
      }
    }

    return message;
  }

  Map<String, dynamic> toJson() {
    return {'type': type, 'content': content};
  }
}
