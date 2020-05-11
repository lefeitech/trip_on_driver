import 'package:driver/common/utils/route_helper.dart';
import 'package:driver/pages/auth/register.dart';
import 'package:driver/shared_state/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigatorUtil {
  static GlobalKey<NavigatorState> navigatorKey = RouteHelper().navigatorKey;

  /// 命名静态路由
  static Map<String, WidgetBuilder> staticRoutes = {
//    LoginPage.routeName: (BuildContext context) => LoginPage(),
  };

  /// register page step 1
  static Future<void> goRegisterStep1() {
    return RouteHelper().pushWidget<void>(ChangeNotifierProvider(
      create: (_) => RegisterProvider(),
      child: RegisterPage(),
    ));
  }
}
