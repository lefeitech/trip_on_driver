import 'dart:convert' show json;

import '../common.dart';

class IOSEvent {
  IOSEvent({
    this.jUid,
    this.jMsgid,
    this.aps,
    this.jBusiness,
    this.content,
    this.type,
  });

  factory IOSEvent.fromJson(Map<String, dynamic> jsonRes) => jsonRes == null
      ? null
      : IOSEvent(
          jUid: asT<int>(jsonRes['_j_uid']),
          jMsgid: asT<int>(jsonRes['_j_msgid']),
          aps: Aps.fromJson(asT<Map<String, dynamic>>(jsonRes['aps'])),
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

  Map<String, dynamic> toJson() => <String, dynamic>{
        '_j_uid': jUid,
        '_j_msgid': jMsgid,
        'aps': aps,
        '_j_business': jBusiness,
        'content': content,
        'type': type,
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
