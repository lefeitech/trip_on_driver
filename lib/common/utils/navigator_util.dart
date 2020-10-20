import 'package:driver/common/model/order/order_detail.dart';
import 'package:driver/common/utils/route_helper.dart';
import 'package:driver/pages/auth/login.dart';
import 'package:driver/pages/auth/register.dart';
import 'package:driver/pages/auth/register_step2.dart';
import 'package:driver/pages/auth/register_step3.dart';
import 'package:driver/pages/order/order_detail.dart';
import 'package:driver/shared_state/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigatorUtil {
  static GlobalKey<NavigatorState> navigatorKey = RouteHelper().navigatorKey;

  /// 命名静态路由
  static Map<String, WidgetBuilder> staticRoutes = {
   LoginPage.routeName: (BuildContext context) => LoginPage(),
  };

  /// register page step 1
  static Future<void> goRegisterStep1() {
    return RouteHelper().pushWidget<void>(ChangeNotifierProvider(
      create: (_) => RegisterProvider(),
      child: RegisterPage(),
    ));
  }

  /// register page step 2
  static Future<void> goRegisterStep2(RegisterProvider provider) {
    return RouteHelper().pushWidget<void>(ChangeNotifierProvider.value(
      value: provider,
      child: RegisterStep2Page(),
    ));
  }

  /// register page step 3
  static Future<void> goRegisterStep3(RegisterProvider provider) {
    return RouteHelper().pushWidget<void>(ChangeNotifierProvider.value(
      value: provider,
      child: RegisterStep3Page(),
    ));
  }

  /// order detail
  static Future<bool> goOrderDetailPage(OrderInfoModel order) {
    return RouteHelper().pushWidget<bool>(OrderDetailPage(order));
  }
}
