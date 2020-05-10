import 'package:driver/common/api/auth/auth.dart';
import 'package:driver/common/config/config.dart';
import 'package:driver/common/enums/auth.dart';
import 'package:driver/common/local/local_storage.dart';
import 'package:driver/common/utils/common_util.dart';
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

  int get loginMethod => _loginMethod;

  int _loginMethod = LoginType.code;

  final TextEditingController _userNameCtrl = TextEditingController();
  final TextEditingController _userPwdCtrl = TextEditingController();

  bool _agreed = true;

  int _secondDec = 0;
  bool _isWxInstall = false;
  bool _loading = false;

  void _init(BuildContext context) {
    if (Config.debugMode) {
      _userNameCtrl.text = Config.TEST_ACCOUNT;
      _userPwdCtrl.text = Config.TEST_PWD;
    }
  }

  void loginTypeChanged() {
    if (_loginMethod == LoginType.code) {
      // todo stop counter , clear code , hide pwd
      _loginMethod = LoginType.pwd;
      _userPwdCtrl.clear();
    } else if (_loginMethod == LoginType.pwd) {
      _loginMethod = LoginType.code;
    }
    print(_loginMethod);
    notifyListeners();
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

  Future<bool> login(BuildContext context) async {
    if (!validatePhone()) {
      CommonUtils.showMessage('please a valid number');
      return Future.value(false);
    }

    if (_userPwdCtrl.text == null || _userPwdCtrl.text == '') {
      final msg = _loginMethod == LoginType.code ? 'please enter code' : 'please enter password';
      CommonUtils.showMessage(msg);
      return Future.value(false);
    }

    var success = true;

    _loading = true;
    notifyListeners();

    try {
      final res = await AuthApi.login(
        tel: _userNameCtrl.text,
        loginMethod: _loginMethod,
        code: _userPwdCtrl.text,
        password: _userPwdCtrl.text,
      );
      if (res.code != 1) {
        // failed
        CommonUtils.showMessage(res.msg);
        success = false;
        return Future.value(false);
      } else {
        await _saveToken(res.data.token);
        // todo save userInfo
        CommonUtils.showMessage('login success');
        success = true;
      }
    } catch (e) {
      CommonUtils.showMessage('login error');
      success = false;
    }
    _loading = false;
    notifyListeners();
    return Future.value(success);
  }

  Future<void> _saveToken(String token) {
    return LocalStorage.set(Config.TOKEN_KEY, token);
  }

  @override
  void dispose() {
    super.dispose();
    _userNameCtrl.dispose();
    _userPwdCtrl.dispose();
  }
}