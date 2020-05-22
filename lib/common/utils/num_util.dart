import 'dart:math' as math;

import 'package:driver/common/config/config.dart';

class NumUtil {
  /// 精确到小数点后几位
  static String getDecimalsNumber(num number, [int precision = 2]) {
    if (number == null) return '0.' + makeUpZero('0', 2);
    int pow = math.pow(10, precision);
    double num = number * pow;
    num = num.roundToDouble() / pow;
    String numStr = num.toString();

    if (numStr.contains('.')) {
      final List<String> spNumStr = numStr.split('.');
      String decimal = makeUpZero(spNumStr.last, precision);
      numStr = '${spNumStr.first}.$decimal';
    } else {
      numStr = numStr + '.' + makeUpZero('0', precision);
    }

    return numStr;
  }

  /// 末尾补0
  static String makeUpZero(String number, int length) {
    String decimal = number ?? '0';
    while (decimal.length < length) {
      decimal = '${decimal}0';
    }
    return decimal;
  }

  /// 精确到小数点后几位
  static String stringAsFixed(double num, [int fractionDigits = 2]) {
    return num.toStringAsFixed(fractionDigits);
  }
}
