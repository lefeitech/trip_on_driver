/// 登录方式
class LoginType {
  static const int code = 1;
  static const int pwd = 2;
}

/// 审核状态
class VerifyStatus {
  static const String unregistered = 'unregistered'; // 未注册
  static const String underReview = 'underReview'; // 正在审核
  static const String registered = 'registered'; // 审核通过
}
