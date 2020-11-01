import 'dart:async';
import 'package:driver/common/config/config.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'package:convert/convert.dart' show hex;
import 'package:crypto/crypto.dart' show md5;

/// 通用逻辑

class CommonUtils {
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

  static String generateMd5(int timeStamp) {
    final originStr = '$timeStamp${Config.HTTP_KEY}version=${Config.HTTP_VERSION}${Config.HTTP_SECRET}';
    final content = Utf8Encoder().convert(originStr);
    final digest = md5.convert(content);
    final md5Str = hex.encode(digest.bytes);
    return md5Str;
  }
}
