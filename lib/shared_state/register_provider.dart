import 'dart:async';
import 'dart:io';
import 'package:driver/common/utils/log.dart';
import 'package:driver/pages/auth/login.dart';
import 'package:flutter/material.dart';

import 'package:driver/common/api/auth/auth.dart';
import 'package:driver/common/api/file.dart';
import 'package:driver/common/model/auth/send_code.dart';
import 'package:driver/common/model/user/user_info.dart';
import 'package:driver/common/utils/common_util.dart';
import 'package:driver/common/utils/navigator_util.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class RegisterProvider with ChangeNotifier {
  var userInfo = UserInfoModel();
  var secondsCount = 60;

  bool get loading => _loading;
  bool _loading = false;

  bool get agreed => _agree;
  bool _agree = false;

  // timer id
  Timer _timer;

  final step1key = GlobalKey<FormState>(debugLabel: 'step1key');

  File card1;
  File card2;

  String _card1str;
  String _card2str;

  List<File> carsImage = List<File>(3);
  List<String> _carsImageStr = List<String>(3);

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

  // car's color
  final carColor = TextEditingController();

  // car seats number
  final carNum = TextEditingController();

  // car's number
  final carNo = TextEditingController();

  // car make
  final carMake = TextEditingController();
  final emailCtrl = TextEditingController();
  final weChatCtrl = TextEditingController();
  final bankNoCtrl = TextEditingController();

  // emergency contact's phone number
  final tel2Ctrl = TextEditingController();

  void saveStep1() {
    if (step1key.currentState.validate()) {
      step1key.currentState.save();
      NavigatorUtil.goRegisterStep2(this);
    }
  }

  void saveStep2() {
    if (card1 == null || card2 == null) {
      return CommonUtils.showMessage('Please pick driver liense photos');
    } else {
      NavigatorUtil.goRegisterStep3(this);
    }
  }

  Future<void> finish(BuildContext context) async {
    bool completed = true;

    if (_loading) {
      return;
    }

    carsImage.forEach((image) => completed = completed && (image != null));
    if (!completed) {
      return CommonUtils.showMessage('Please pick three side car photos');
    }

    if (carNo.text == null) {
      return CommonUtils.showMessage('Please type Car Plate Number');
    }

    if (carNum.text == null) {
      return CommonUtils.showMessage('Please type car\'s seats number');
    }

    if (_agree == false) {
      return CommonUtils.showMessage(
          'Please agree the \'User Services Agreement\'');
    }

    _loading = true;
    EasyLoading.show(status: 'loading');

    try {
      _carsImageStr = await _uploadImages(carsImage);
      var cardImageStr = await _uploadImages([card1, card2]);
      _card1str = cardImageStr[0];
      _card2str = cardImageStr[1];
      if (await _register()) {
        LogUtil.v('register success');
        CommonUtils.showMessage('register success');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
        );
      } else {
        LogUtil.v('some bad thing happened');
        // return CommonUtils.showMessage('some bad thing happened');
      }
    } catch (e) {
      LogUtil.v('some error happened');
      return CommonUtils.showMessage('some error happened');
    } finally {
      EasyLoading.dismiss();
      _loading = false;
    }
  }

  Future<List<String>> _uploadImages(List<File> files) async {
    final res =
        await Future.wait(files.map((image) => FileApi.uploadOneImage(image)));
    List<String> imagesUrl;
    if (res[0].code == 1) {
      imagesUrl = res.map((item) => item.data.baseUrl).toList();
      return Future.value(imagesUrl);
    } else {
      return Future.value(null);
    }
  }

  Future<bool> _register() async {
    var userInfo = UserInfoModel(
      driverTel: telCtrl.text,
      driverName: nameCtrl.text,
      driverNameEn: enNameCtrl.text,
      card1: _card1str,
      card2: _card2str,
      cardNo: cardCtrl.text,
      carNo: carNo.text,
      carMake: carMake.text,
      carColor: carColor.text,
      carSlide: _carsImageStr,
      carNum: int.tryParse(carNum.text),
      password: pwdCtrl.text,
      email: emailCtrl.text,
      bankNo: bankNoCtrl.text,
      tel2: tel2Ctrl.text,
      code: int.tryParse(codeCtrl.text),
    );
    try {
      var res = await AuthApi.register(userInfo);
      if (res.code == 1) {
        return Future.value(true);
      } else {
        CommonUtils.showMessage(res.msg);
      }
    } catch (e) {
      LogUtil.v(e);
    }

    return Future.value(false);
  }

  /// 发送验证码
  Future<void> sendCode() async {
    if (!validatePhone(telCtrl.text)) {
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
    return tel != null &&
        (tel.length == 11 || tel.length == 10 || tel.length == 9);
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

  void agreeClicked() {
    _agree = !_agree;
    notifyListeners();
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
    carNo.dispose();
    carColor.dispose();
    carNum.dispose();
    carMake.dispose();
    emailCtrl.dispose();
    weChatCtrl.dispose();
    bankNoCtrl.dispose();
    tel2Ctrl.dispose();
  }
}
