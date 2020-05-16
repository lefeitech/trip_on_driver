import 'package:dio/dio.dart' show Response;
import 'package:driver/common/enums/auth.dart';
import 'package:driver/common/model/auth/login_res.dart';
import 'package:driver/common/model/auth/send_code.dart';
import 'package:driver/common/model/user/user_info.dart';
import 'package:driver/common/model/user/user_info_res.dart';
import 'package:driver/common/network/base_url.dart';
import 'package:driver/common/network/common_http.dart';

class AuthApi {

  static  CommonHttp http = CommonHttp();

  /// 获取订单列表
  static Future<SendCodeRes> getOrderList(String driverId, {int start = 0, count = 20, int state = -1}) async {
    final body = {
      'driver_id': driverId,
      'start': start,
      'count': count,
      'state': state,
    };
    Response res = await http.post(BaseUrl.orderList, data: body);
    return SendCodeRes.fromJson(res.data);
  }

  /// 获取订单详情
  static Future<UserInfoRes> getOrderDetail(String id) async {
    Response res = await http.post(BaseUrl.orderDetail, data: {'order_id': id});
    return UserInfoRes.fromJson(res.data);
  }

}
