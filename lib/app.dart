import 'package:driver/common/style/custom_theme.dart';
import 'package:driver/common/utils/navigator_util.dart';
import 'package:driver/pages/splash.dart';
import 'package:flutter/material.dart';

class DriverApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tripon driver',
      routes: NavigatorUtil.staticRoutes,
      navigatorKey: NavigatorUtil.navigatorKey,
      home: SplashPage(),
      themeMode: ThemeMode.light,
      theme: CustomTheme.getSystemTheme(context),
    );
  }
}
