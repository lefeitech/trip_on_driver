import 'dart:convert' show json;

T asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }

  return null;
}

class PushEventModal {
  PushEventModal({this.type, this.content});

  String type;
  Map<String, dynamic> content;

  factory PushEventModal.fromJson(Map<String, dynamic> jsonRes) =>
      jsonRes == null
          ? null
          : PushEventModal(
              type: asT<String>(jsonRes['type']),
              content: asT<Map>(jsonRes['content']));

  Map<String, dynamic> toJson() => <String, dynamic>{
        'type': type,
        'content': json.encode(content),
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
