import 'package:driver/common/config/config.dart';
import 'package:driver/common/local/local_storage.dart';
import 'package:driver/pages/splash.dart';
import 'package:driver/pages/tab.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  static const String routeName = 'setting-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
        centerTitle: true,
      ),
      body: Center(
        child: RaisedButton(
          color: Theme.of(context).primaryColor,
          child: Text('logout',style: TextStyle(color: Colors.white)),
          onPressed: () async {
            await LocalStorage.remove(Config.TOKEN_KEY);
            await LocalStorage.remove(Config.USER_ID);
            Navigator.popUntil(context, ModalRoute.withName(TabPage.routeName));
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SplashPage(),
              ),
            );
          },
        ),
      ),
    );
  }
}
