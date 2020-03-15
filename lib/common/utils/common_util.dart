import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:intl/intl.dart' show DateFormat;
import 'package:oktoast/oktoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

/// 通用逻辑

class CommonUtils {
  static String formatTimeFromMill(int mill, [String format = 'yyyy-MM-dd HH:mm']) {
    DateFormat formatter = DateFormat(format);
    return formatter.format(DateTime.fromMillisecondsSinceEpoch(mill));
  }

  static String formatTimeFromDateTime(DateTime time, [String format = 'yyyy-MM-dd HH:mm']) {
    DateFormat formatter = DateFormat(format);
    return formatter.format(DateTime.fromMillisecondsSinceEpoch(time.millisecondsSinceEpoch));
  }

  static void showMessage(String msg) {
    showToast(
      msg,
      dismissOtherToast: true,
      position: ToastPosition.bottom,
      textPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    );
  }


  static Future<void> callPhone(BuildContext context, String phoneNum) async {
    if (phoneNum == null || phoneNum == '') return showMessage('号码为空');
    String url = 'tel:$phoneNum';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showMessage('调起电话失败');
    }
  }

  /// 判断是否是URL
  static bool isURL(String path) {
    return path.contains('http://') || path.contains('https://');
  }


  // 格式化手机号为 133****1111
  static String formatHiddenPhone(String phone) {
    if (phone is String && phone.isNotEmpty) {
      if (phone.length == 11) {
        return phone.replaceRange(3, 7, '****');
      } else if (phone.length > 3) {
        final int le = (phone.length / 3).floor();

        return phone.replaceRange(le, 2 * le, '****');
      }
    }
    return null;
  }
}
