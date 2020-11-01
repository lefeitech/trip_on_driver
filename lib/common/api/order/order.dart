import 'package:dio/dio.dart' show Response;
import 'package:driver/common/model/common.dart';
import 'package:driver/common/model/order/order_detail_res.dart';
import 'package:driver/common/model/order/order_list_res.dart';
import 'package:driver/common/model/order/rob_list_res.dart';
import 'package:driver/common/network/base_url.dart';
import 'package:driver/common/network/common_http.dart';
import 'package:flutter/cupertino.dart';

class OrderApi {
  static CommonHttp http = CommonHttp();

  /// 获取订单列表
  static Future<OrderListRes> getOrderList(String driverId,
      {int start = 0, count = 20, int state = -1}) async {
    final body = {
      'driver_id': driverId,
      'start': start,
      'count': count,
      'state': state,
    };
    Response res = await http.post(BaseUrl.orderList, data: body);
    return OrderListRes.fromJson(res.data);
  }

  /// 获取订单详情
  static Future<OrderDetailRes> getOrderDetail(int id) async {
    Response res = await http.post(BaseUrl.orderDetail, data: {'order_id': id});
    return OrderDetailRes.fromJson(res.data);
  }

  // 获取抢单列表
  static Future<RobListRes> getRobList(String driverId,
      {int start = 0, count = 20}) async {
    final query = {
      'driver_id': driverId,
      'start': start,
      'count': count,
    };
    Response res = await http.get(BaseUrl.robList, queryParameters: query);
    return RobListRes.fromJson(res.data);
  }

  /// 抢单
  static Future<StringRes> robOrder({
    @required String orderId,
    @required String driverId,
  }) async {
    final body = {
      'driver_id': driverId,
      'order_id': orderId,
    };
    Response res = await http.post(BaseUrl.robState, data: body);
    return StringRes.fromJson(res.data);
  }

  /// change order status
  static Future<StringRes> changeOrderStatus({
    @required int orderId,
    @required int state,
  }) async {
    final body = {
      'state': state,
      'order_id': orderId,
    };
    Response res = await http.post(BaseUrl.orderState, data: body);
    return StringRes.fromJson(res.data);
  }
}
