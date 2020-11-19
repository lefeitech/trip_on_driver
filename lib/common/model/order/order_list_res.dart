import 'dart:convert' show json;
import 'package:driver/common/model/common.dart' show asT;

import 'order_detail.dart';

class OrderListRes {
  OrderListRes({
    this.code,
    this.msg,
    this.data,
  });

  factory OrderListRes.fromJson(Map<String, dynamic> jsonRes) => jsonRes == null
      ? null
      : OrderListRes(
          code: asT<int>(jsonRes['code']),
          msg: asT<String>(jsonRes['msg']),
          data: OrderListData.fromJson(
              asT<Map<String, dynamic>>(jsonRes['data'])),
        );

  int code;
  String msg;
  OrderListData data;

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

class OrderListData {
  OrderListData({
    this.count,
    this.info,
    this.finish,
  });

  factory OrderListData.fromJson(Map<String, dynamic> jsonRes) {
    if (jsonRes == null) {
      return null;
    }

    final List<OrderInfoModel> info =
        jsonRes['info'] is List ? <OrderInfoModel>[] : null;
    if (info != null) {
      for (final dynamic item in jsonRes['info']) {
        if (item != null) {
          info.add(OrderInfoModel.fromJson(asT<Map<String, dynamic>>(item)));
        }
      }
    }
    return OrderListData(
      count: asT<int>(jsonRes['count']),
      info: info,
      finish: asT<int>(jsonRes['finish']),
    );
  }

  int count;
  List<OrderInfoModel> info;
  int finish;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'count': count,
        'info': info,
        'finish': finish,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
