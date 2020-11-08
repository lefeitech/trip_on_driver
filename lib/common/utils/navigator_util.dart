import 'package:driver/common/model/order/order_detail.dart';
import 'package:driver/common/model/order/rob_list_res.dart';
import 'package:driver/common/utils/route_helper.dart';
import 'package:driver/pages/auth/login.dart';
import 'package:driver/pages/auth/register.dart';
import 'package:driver/pages/auth/register_step2.dart';
import 'package:driver/pages/auth/register_step3.dart';
import 'package:driver/pages/mine/car_info.dart';
import 'package:driver/pages/mine/my_infomation.dart';
import 'package:driver/pages/order/order_detail.dart';
import 'package:driver/pages/order/party_order_list_page.dart';
import 'package:driver/pages/rob/rob_detail.dart';
import 'package:driver/shared_state/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigatorUtil {
  static GlobalKey<NavigatorState> navigatorKey = RouteHelper().navigatorKey;

  /// 命名静态路由
  static Map<String, WidgetBuilder> staticRoutes = {
    LoginPage.routeName: (BuildContext context) => LoginPage(),
    MyInfomationPage.routeName: (BuildContext context) => MyInfomationPage(),
    CarInfoPage.routeName: (BuildContext context) => CarInfoPage(),
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

  /// order list without tab
  static Future<void> goPartyOrderListPage(int state, {String title}) {
    return RouteHelper().pushWidget(PartyOrderListPage(
      state: state,
      title: title,
    ));
  }

  /// rob item detail
  static Future<void> goRobDetailPage(RobInfo info) {
    return RouteHelper().pushWidget(RobDetailPage(info));
  }
}
