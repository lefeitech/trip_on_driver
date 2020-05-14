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
  /// 获取验证码
  static Future<SendCodeRes> smsSendLoginCode(String phone) async {
    Response res = await http.post(BaseUrl.sendCode, data: {'tel': phone});
    return SendCodeRes.fromJson(res.data);
  }

  /// 获取用户信息
  static Future<UserInfoRes> getUserInfo(int driverId) async {
    Response res = await http.post(BaseUrl.userInfo, data: {'driver_id': driverId});
    return UserInfoRes.fromJson(res.data);
  }

  /// 注册
  static Future<UserInfoRes> register(UserInfoModel userInfo) async {
    Response res = await http.post(BaseUrl.userRegister, data: userInfo.toJson());
    return UserInfoRes.fromJson(res.data);
  }

  /// 校验验证码
//  static Future<ResultWithTokenModel> smsValidateLoginCode(String phone, String code) async {
//    Response res = await CommonHttp().post(
//      '${BaseUrl.auth}/sms-login-code-validate',
//      data: {'phone': phone, 'code': code},
//    );
//    return ResultWithTokenModel.fromJson(res.data);
//  }

  /// 校验验wx code
//  static Future<UnionIdRes> getUnionId(String code) async {
//    Response res = await CommonHttp().post(
//      '${BaseUrl.wxAuth}/shop-app-oauth',
//      data: {'code': code},
//    );
//    return UnionIdRes.fromJson(res.data);
//  }

  /// 登录 [LoginMethod]
  /// [loginMethod]	1是验证码登陆，2是密码登陆
  static Future<LoginRes> login({String tel, int loginMethod, String code, String password}) async {
    Response res = await http.post(
      BaseUrl.userLogin,
      data: {
        'tel': tel,
        'type': loginMethod,
        if (loginMethod == LoginType.code) 'code': code,
        if (loginMethod == LoginType.pwd) 'password': password,
      },
    );
    return LoginRes.fromJson(res.data);
  }
}
