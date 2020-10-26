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
        typeStr = 'Canceled';
        break;
      case OrderState.pendingPay:
        typeStr = 'Paying';
        break;
      case OrderState.paied:
        typeStr = 'Paied';
        break;
      case OrderState.picked:
        typeStr = 'Picked';
        break;
      case OrderState.passengerOnBoard:
        typeStr = 'Confirmed';
        break;
      case OrderState.done:
        typeStr = 'Done';
        break;
      default:
        break;
    }
    return typeStr;
  }
}
