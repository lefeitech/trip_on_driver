import 'dart:async';

import 'package:driver/common/api/auth/auth.dart';
import 'package:driver/common/model/auth/send_code.dart';
import 'package:driver/common/model/user/user_info.dart';
import 'package:driver/common/utils/common_util.dart';
import 'package:driver/common/utils/navigator_util.dart';
import 'package:flutter/material.dart';

class RegisterProvider with ChangeNotifier {
  var userInfo = UserInfoModel();
  var secondsCount = 60;

  Timer _timer;

  final step1key = GlobalKey<FormState>(debugLabel: 'step1key');
  final step2key = GlobalKey<FormState>(debugLabel: 'step2key');
  final step3key = GlobalKey<FormState>(debugLabel: 'step3key');

  // full name
  final nameCtrl = TextEditingController();

  // en-name
  final enNameCtrl = TextEditingController();

  // phone number
  final telCtrl = TextEditingController();

  // sms verify code
  final codeCtrl = TextEditingController();
  final pwdCtrl = TextEditingController();
  final rePwdCtrl = TextEditingController();

  // driver's license
  final cardCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final weChatCtrl = TextEditingController();
  final bankNoCtrl = TextEditingController();

  // emergency contact's phone number
  final tel2Ctrl = TextEditingController();

  void saveStep1() {
    if (step1key.currentState.validate()) {
      step1key.currentState.save();
      // todo next step
      NavigatorUtil.goRegisterStep2(this);
    }
  }

  /// 发送验证码
  Future<void> sendCode() async {
    if (validatePhone(telCtrl.text)) {
      return CommonUtils.showMessage('please a valid number');
    }
    if (_timer != null) {
      return Future.value();
    }
    try {
      SendCodeRes res = await AuthApi.smsSendLoginCode(telCtrl.text);
      if (res.code == 1) {
        _autoDecSecond();
        return CommonUtils.showMessage('send success');
      } else {
        return CommonUtils.showMessage('send failed');
      }
    } catch (e) {
      return CommonUtils.showMessage('send failed');
    }
  }

  String getCodeStr(BuildContext context) {
    return _timer == null ? 'send code' : secondsCount.toString();
  }

  bool validatePhone(String tel) {
    return tel != null && tel.length == 11;
  }

  void _autoDecSecond() {
    secondsCount = 60;
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (--secondsCount == 0) {
        timer.cancel();
        _timer = null;
      }
      notifyListeners();
    });
  }

  @override
  void dispose() {
    super.dispose();
    nameCtrl.dispose();
    enNameCtrl.dispose();
    telCtrl.dispose();
    codeCtrl.dispose();
    pwdCtrl.dispose();
    rePwdCtrl.dispose();
    cardCtrl.dispose();
    emailCtrl.dispose();
    weChatCtrl.dispose();
    bankNoCtrl.dispose();
    tel2Ctrl.dispose();
  }
}
