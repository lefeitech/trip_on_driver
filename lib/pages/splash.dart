import 'package:driver/common/config/config.dart';
import 'package:driver/common/local/local_storage.dart';
import 'package:driver/pages/auth/login.dart';
import 'package:driver/pages/tab.dart';
import 'package:driver/shared_state/user_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Consumer<UserInfoProvider>(
        child: Center(child: CircularProgressIndicator()),
        builder: (BuildContext context, UserInfoProvider userInfo, Widget child) {
          return _SplashBody(userInfo, child: child);
        },
      ),
    );
  }
}

class _SplashBody extends StatefulWidget {
  _SplashBody(this.userInfoProvider, {this.child});

  final UserInfoProvider userInfoProvider;
  final Widget child;

  @override
  __SplashBodyState createState() => __SplashBodyState();
}

class __SplashBodyState extends State<_SplashBody> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  // todo get user info action move to some Provider
  Future<bool> _init() async {
    final token = await LocalStorage.get(Config.TOKEN_KEY);
    final driverIdStr = await LocalStorage.get(Config.USER_ID);
    if (token != null && driverIdStr != null) {
      widget.userInfoProvider.getUserInfo(int.parse(driverIdStr));
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
