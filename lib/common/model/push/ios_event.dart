import 'dart:convert' show json;
import 'package:driver/common/model/push/push_event.dart';
import '../common.dart';

class IOSEventModel {
  IOSEventModel({
    this.jUid,
    this.jMsgid,
    this.aps,
    this.jBusiness,
    this.content,
    this.type,
    this.title,
    this.extras,
  });

  factory IOSEventModel.fromJson(Map<String, dynamic> jsonRes) =>
      jsonRes == null
          ? null
          : IOSEventModel(
              jUid: asT<int>(jsonRes['_j_uid']),
              title: asT<String>(jsonRes['title']),
              jMsgid: asT<int>(jsonRes['_j_msgid']),
              aps: Aps.fromJson(asT<Map<String, dynamic>>(jsonRes['aps'])),
              extras: jsonRes['extras'] == null
                  ? null
                  : MessageContent.fromJson(json.decode(json.encode(jsonRes['extras']))),
              jBusiness: asT<int>(jsonRes['_j_business']),
              content: asT<String>(jsonRes['content']),
              type: asT<String>(jsonRes['type']),
            );

  int jUid;
  int jMsgid;
  Aps aps;
  int jBusiness;
  String content;
  String type;
  String title;
  MessageContent extras;

  Map<String, dynamic> toJson() => <String, dynamic>{
        '_j_uid': jUid,
        '_j_msgid': jMsgid,
        'aps': aps,
        'extras': extras,
        '_j_business': jBusiness,
        'content': content,
        'type': type,
        'title': title,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Aps {
  Aps({
    this.alert,
    this.badge,
    this.sound,
  });

  factory Aps.fromJson(Map<String, dynamic> jsonRes) => jsonRes == null
      ? null
      : Aps(
          alert: asT<String>(jsonRes['alert']),
          badge: asT<int>(jsonRes['badge']),
          sound: asT<String>(jsonRes['sound']),
        );

  String alert;
  int badge;
  String sound;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'alert': alert,
        'badge': badge,
        'sound': sound,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
