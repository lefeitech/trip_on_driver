import 'dart:convert' show json;
import 'package:driver/common/model/common.dart' show asT;

class SendCodeRes {
  SendCodeRes({
    this.code,
    this.msg,
    this.data,
  });

  factory SendCodeRes.fromJson(Map<String, dynamic> jsonRes) => jsonRes == null
      ? null
      : SendCodeRes(
    code: asT<int>(jsonRes['code']),
    msg: asT<String>(jsonRes['msg']),
    data: CodeDate.fromJson(asT<Map<String, dynamic>>(jsonRes['data'])),
  );

  int code;
  String msg;
  CodeDate data;

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

class CodeDate {
  CodeDate({
    this.tel,
    this.code,
    this.time,
  });

  factory CodeDate.fromJson(Map<String, dynamic> jsonRes) => jsonRes == null
      ? null
      : CodeDate(
    tel: asT<String>(jsonRes['tel']),
    code: asT<int>(jsonRes['code']),
    time: asT<int>(jsonRes['time']),
  );

  String tel;
  int code;
  int time;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'tel': tel,
    'code': code,
    'time': time,
  };
  @override
  String toString() {
    return json.encode(this);
  }
}
