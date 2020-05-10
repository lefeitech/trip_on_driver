import 'dart:convert' show json;
import 'package:driver/common/model/common.dart' show asT;
import 'package:driver/common/model/user/user_info.dart';

class LoginRes {
  LoginRes({
    this.code,
    this.msg,
    this.data,
  });

  factory LoginRes.fromJson(Map<String, dynamic> jsonRes) => jsonRes == null
      ? null
      : LoginRes(
          code: asT<int>(jsonRes['code']),
          msg: asT<String>(jsonRes['msg']),
          data: LoginData.fromJson(asT<Map<String, dynamic>>(jsonRes['data'])),
        );

  int code;
  String msg;
  LoginData data;

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

class LoginData {
  LoginData({
    this.token,
    this.info,
  });

  factory LoginData.fromJson(Map<String, dynamic> jsonRes) => jsonRes == null
      ? null
      : LoginData(
          token: asT<String>(jsonRes['token']),
          info: UserInfoModel.fromJson(asT<Map<String, dynamic>>(jsonRes['info'])),
        );

  String token;
  UserInfoModel info;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'token': token,
        'info': info,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
