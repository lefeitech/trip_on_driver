import 'dart:convert' show json;
import 'package:driver/common/model/common.dart' show asT;

import 'order_detail.dart';

class OrderDetailRes {
  OrderDetailRes({
    this.code,
    this.msg,
    this.data,
  });

  factory OrderDetailRes.fromJson(Map<String, dynamic> jsonRes) => jsonRes == null
      ? null
      : OrderDetailRes(
          code: asT<int>(jsonRes['code']),
          msg: asT<String>(jsonRes['msg']),
          data: OrderInfoModel.fromJson(asT<Map<String, dynamic>>(jsonRes['data'])),
        );

  int code;
  String msg;
  OrderInfoModel data;

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
