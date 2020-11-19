import 'package:driver/common/config/config.dart';
import 'package:driver/common/local/local_storage.dart';
import 'package:driver/pages/auth/login.dart';
import 'package:driver/pages/tab.dart';
import 'package:flutter/material.dart';

class SplashProvider with ChangeNotifier {
  Future<bool> init(BuildContext context,
      {Future Function(int driverId) future}) async {
    final token = await LocalStorage.get(Config.TOKEN_KEY);
    final driverIdStr = await LocalStorage.get(Config.USER_ID);
    if (token != null && driverIdStr != null) {
//      _getUserInfo(context, int.parse(driverIdStr));
      await future(int.parse(driverIdStr));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (BuildContext context) => TabPage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
      );
    }
    return Future.value(true);
  }
}
