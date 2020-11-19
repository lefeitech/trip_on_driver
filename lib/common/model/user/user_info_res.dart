import 'package:driver/common/model/common.dart' show asT;
import 'dart:convert' show json;

import 'package:driver/common/model/user/user_info.dart';

class UserInfoRes {
  UserInfoRes({
    this.code,
    this.msg,
    this.data,
  });

  factory UserInfoRes.fromJson(Map<String, dynamic> jsonRes) => jsonRes == null
      ? null
      : UserInfoRes(
          code: asT<int>(jsonRes['code']),
          msg: asT<String>(jsonRes['msg']),
          data: UserInfoModel.fromJson(
              asT<Map<String, dynamic>>(jsonRes['data'])),
        );

  int code;
  String msg;
  UserInfoModel data;

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
