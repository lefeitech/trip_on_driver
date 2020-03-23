import 'package:driver/common/config/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';

class LoginProvider with ChangeNotifier {
  LoginProvider(BuildContext context) {
    _init(context);
  }

  TextEditingController get userNameCtrl => _userNameCtrl;

  TextEditingController get userPwdCtrl => _userPwdCtrl;

  int get secondDec => _secondDec;

  bool get isWxInstalled => _isWxInstall;

  bool get agreed => _agreed;

  final TextEditingController _userNameCtrl = TextEditingController();
  final TextEditingController _userPwdCtrl = TextEditingController();

  bool _agreed = false;

  int _secondDec = 0;
  bool _isWxInstall = false;
  bool _loading = false;

  void _init(BuildContext context) {
    if (Config.debugMode) {
      _userNameCtrl.text = '13867348879';
      _userPwdCtrl.text = '888777';
    }
  }

  void agreeClicked() {
    _agreed = !_agreed;
    notifyListeners();
  }

  /// 发送验证码
  Future<void> sendCode(BuildContext context) async {
//    if (!validatePhone()) {
//      return CommonUtils.showMessage('请输入正确的手机号');
//    }
//    try {
//      ResponseBaseModel res = await AuthApi.smsSendLoginCode(_userNameCtrl.text);
//      if (res.status == 20000) {
//        CommonUtils.showMessage('发送成功');
//      } else {
//        return CommonUtils.showMessage('发送失败');
//      }
//    } catch (e) {
//      return CommonUtils.showMessage('发送失败');
//    }
//    _secondDec = 60;
    _autoDecSecond();
  }

  void _autoDecSecond() {
    _secondDec--;
    notifyListeners();
    if (_secondDec != 0) {
      Timer(Duration(seconds: 1), _autoDecSecond);
    }
  }

  bool validatePhone() {
    // todo more check
    return _userNameCtrl.text.length == 11;
  }

  /// 手机号、密码登录
  Future<void> smsValidateLoginCode(BuildContext context) async {
    if (!validatePhone()) {
//      return CommonUtils.showMessage('请输入正确的手机号');
    }

    if (_userPwdCtrl.text == null || _userPwdCtrl.text == '') {
//      return CommonUtils.showMessage('请输入验证码');
    }

    if (_loading) return null;
    _loading = true;
//    try {
//      ResultWithTokenModel res;
//      // 如果是测试账号，直接登录，否则校验验证码
//      if (_userNameCtrl.text == '13867348879' && _userPwdCtrl.text == '888777') {
//        res = await AuthApi.login(_userNameCtrl.text, LoginMethod.CELLPHONE);
//      } else {
//        res = await AuthApi.smsValidateLoginCode(_userNameCtrl.text, _userPwdCtrl.text);
//      }
//      if (res.status == 20000 && res.token is String && res.token.length > 0) {
//        await LocalStorage.set(Config.LOGIN_METHOD, LoginMethod.CELLPHONE);
//        await LocalStorage.set(Config.CELLPHONE, _userNameCtrl.text);
//        await _saveToken(context, res.token);
//      } else {
//        CommonUtils.showMessage('验证码错误');
//      }
//    } catch (e) {
//      CommonUtils.showMessage('请求异常');
//    }
    _loading = false;
  }

  @override
  void dispose() {
    super.dispose();
    _userNameCtrl.dispose();
    _userPwdCtrl.dispose();
  }
}
