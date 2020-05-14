import 'dart:convert' show json;

T asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }

  return null;
}

class StringRes {
  StringRes({
    this.code,
    this.msg,
    this.data,
  });

  factory StringRes.fromJson(Map<String, dynamic> jsonRes) => jsonRes == null
      ? null
      : StringRes(
          code: asT<int>(jsonRes['code']),
          msg: asT<String>(jsonRes['msg']),
          data: asT<String>(jsonRes['data']),
        );

  int code;
  String msg;
  String data;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'code': code,
        'msg': msg,
        'data': data,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
