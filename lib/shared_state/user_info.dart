import 'package:driver/common/api/auth/auth.dart';
import 'package:driver/common/model/user/user_info.dart';
import 'package:driver/common/model/user/user_info_res.dart';
import 'package:driver/common/utils/common_util.dart';
import 'package:flutter/material.dart';

class UserInfoProvider with ChangeNotifier {
  UserInfoModel get userInfo => _userInfo;
  UserInfoModel _userInfo;

  bool get loading => _loading;
  var _loading = false;

  Future<bool> getUserInfo(int driverId, [bool notify = true]) async {
    var success = true;
    _loading = true;

    if (notify) {
      notifyListeners();
    }

    try {
      UserInfoRes res = await AuthApi.getUserInfo(driverId);
      if (res.code == 1) {
        _userInfo = res.data;
        success = true;
        CommonUtils.showMessage('send success');
      } else {
        success = false;
        CommonUtils.showMessage(res.msg);
      }
    } catch (e) {
      CommonUtils.showMessage('fetch user info failed');
      success = false;
    }

    _loading = false;
    if (notify) {
      notifyListeners();
    }
    return Future.value(success);
  }
}
