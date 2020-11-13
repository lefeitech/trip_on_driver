/// 订单状态
class OrderState {
  // all
  static const int all = -1;

  // 取消
  static const int canceled = -2;

  // 待支付
  static const int pendingPay = 1;

  // 付款成功
  static const int paied = 2;

  // 已接单
  static const int picked = 3;

  // 乘客确认上车
  static const int passengerOnBoard = 4;

  // 已完成
  static const int done = 8;
}

/// 行程类型
class TransformType {
  // 接机
  static const int pickUp = 1;

  // 送机
  static const int dropUp = 2;
}

// TODO: service type
class ServiceType {
  static const int pickUpBand = 1;
  static const int dropUp = 2;
}

class OrderType {
  // 接送机
  static const int airport = 1;
  // 包车游
  static const int charter = 2;
  // 租车
  static const int rental = 3;
  // 目的地
  static const int destination = 4;
  // 定制游
  static const int custom = 5;
  // 通用
  static const int normal = 6;
  // 网约车
  static const int rideHailing = 7;
}
