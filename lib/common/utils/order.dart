import 'package:driver/common/enums/order.dart';

class OrderUtil {
  static String getTransformType(int type) {
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
}
