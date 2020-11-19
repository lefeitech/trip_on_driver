import 'package:driver/common/model/order/order_detail.dart';
import 'package:driver/common/model/push/android_event.dart';
import 'package:driver/common/model/push/ios_event.dart';

import '../common.dart';

/// combine android and ios notification together
///
/// blow properties in android and ios origin key are:
///
/// ------------------------------------------------------------------
/// | property         | android                          | ios      |
/// | ---------------- | -------------------------------- | :------- |
/// | [notificationId] | cn.jpush.android.NOTIFICATION_ID | _j_uid   |
/// | [message]        | cn.jpush.android.EXTRA           | extras   |
/// | [origin]         | AndroidEventModel                | IOSEventModel |
/// ------------------------------------------------------------------

class PushEventModal<T> {
  int notificationId;
  MessageContent message;
  String title;
  String alert;
  T origin;

  PushEventModal({
    this.notificationId,
    this.message,
    this.title,
    this.alert,
    this.origin,
  });

  PushEventModal.fromAndroid(T event) : assert(event is AndroidEventModal) {
    if (event is AndroidEventModal) {
      notificationId = event.extras.notificationId;
      message = event.extras.extra;
      alert = event.alert;
      title = event.title;
    }
    origin = event;
  }

  PushEventModal.fromIos(T event) : assert(event is IOSEventModel) {
    if (event is IOSEventModel) {
      notificationId = event.jUid;
      message = event.extras;
      title = event.title;
      alert = event.aps?.alert;
    }
    origin = event;
  }
}

/// parse message form push event
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
    final info = jsonRes['content'];

    message.type = type;

    if (info == null) {
      return message;
    }

    if (type == 'rob') {
      message.content =
          OrderInfoModel.fromJson(asT<Map<String, dynamic>>(info));
    }

    return message;
  }

  Map<String, dynamic> toJson() {
    return {'type': type, 'content': content};
  }
}
