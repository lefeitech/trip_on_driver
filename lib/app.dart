import 'package:driver/common/style/custom_theme.dart';
import 'package:driver/common/utils/navigator_util.dart';
import 'package:driver/pages/home/home.dart';
import 'package:flutter/material.dart';

class DriverApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) => MaterialApp(
        title: 'Trip on Driver',
        routes: NavigatorUtil.staticRoutes,
        navigatorKey: NavigatorUtil.navigatorKey,
        home: HomePage(),
        theme: CustomTheme.getSystemTheme(context),
      ),
    );
  }
}
