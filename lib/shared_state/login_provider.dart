import 'dart:convert';

import 'package:driver/common/api/auth/auth.dart';
import 'package:driver/common/config/config.dart';
import 'package:driver/common/enums/auth.dart';
import 'package:driver/common/local/local_storage.dart';
import 'package:driver/common/model/auth/send_code.dart';
import 'package:driver/common/model/user/user_info.dart';
import 'package:driver/common/utils/common_util.dart';
import 'package:driver/shared_state/push_service.dart';
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

  bool get loading => _loading;

  UserInfoModel get userInfo => _userInfo;
  UserInfoModel _userInfo;

  int _loginMethod = LoginType.pwd;

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
      // todo stop counter
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
    if (!validatePhone()) {
      return CommonUtils.showMessage('please a valid number');
    }
    try {
      SendCodeRes res = await AuthApi.smsSendLoginCode(_userNameCtrl.text);
      if (res.code == 1) {
        CommonUtils.showMessage('send success');
      } else {
        return CommonUtils.showMessage('send failed');
      }
    } catch (e) {
      return CommonUtils.showMessage('send failed');
    }
    _secondDec = 60;
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
    return _userNameCtrl.text.length == 11 ||
        _userNameCtrl.text.length == 10 ||
        _userNameCtrl.text.length == 9;
  }

  Future<bool> login(BuildContext context) async {
    if (!validatePhone()) {
      CommonUtils.showMessage('please a valid number');
      return Future.value(false);
    }

    if (_userPwdCtrl.text == null || _userPwdCtrl.text == '') {
      final msg = _loginMethod == LoginType.code
          ? 'please enter code'
          : 'please enter password';
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
        _userInfo = res.data.info;
        await _saveToken(res.data.token);
        await _saveUserInfo(res.data.info);
        PushService.setTags(['driver']);
        PushService.setAlias(res.data.info.id.toString());
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

  Future<void> _saveUserInfo(UserInfoModel userInfo) async {
    await LocalStorage.set(Config.VERIFY_STATUS, VerifyStatus.registered);
    await LocalStorage.set(Config.USER_ID, userInfo.id.toString());
    await LocalStorage.set(Config.USER_NAME_KEY, userInfo.driverName);
    await LocalStorage.set(Config.USER_INFO, json.encode(userInfo.toJson()));
  }

  @override
  void dispose() {
    super.dispose();
    _userNameCtrl.dispose();
    _userPwdCtrl.dispose();
  }
}
