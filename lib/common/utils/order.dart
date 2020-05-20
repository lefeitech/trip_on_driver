import 'package:driver/common/enums/order.dart';

class OrderUtil {
  /// map order transform status
  /// !info : for internationalize
  static String mapTransformType(int type) {
    var typeStr = '';
    switch (type) {
      case TransformType.pickUp:
        typeStr = 'Pick up';
        break;
      default:
        typeStr = 'Drop up';
        break;
    }
    return typeStr;
  }

  /// map order status [OrderState]
  /// !info : for internationalize
  static String mapOrderStatus(int type) {
    var typeStr = 'unknown';
    switch (type) {
      case OrderState.canceled:
        typeStr = '取消';
        break;
      case OrderState.pendingPay:
        typeStr = '待支付';
        break;
      case OrderState.payed:
        typeStr = '付款成功';
        break;
      case OrderState.picked:
        typeStr = '确认接单';
        break;
      case OrderState.passengerOnBoard:
        typeStr = '乘客确认上车';
        break;
      case OrderState.done:
        typeStr = '已完成';
        break;
      default:
        break;
    }
    return typeStr;
  }
}
