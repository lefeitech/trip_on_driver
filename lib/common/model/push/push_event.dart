import '../common.dart';
import '../order/rob_list_res.dart';

class PushEventModal {
  PushEventModal();
  // todo delete this after combine [AndroidEvent] and [IOSEvent]
  factory PushEventModal.fromJson(Map<String, dynamic> jsonRes) {
    return PushEventModal();
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
