import 'package:driver/common/utils/route_helper.dart';
import 'package:flutter/material.dart';

class NavigatorUtil {
  static GlobalKey<NavigatorState> navigatorKey = RouteHelper().navigatorKey;

  /// 命名静态路由
  static Map<String, WidgetBuilder> staticRoutes = {
//    LoginPage.routeName: (BuildContext context) => LoginPage(),
  };

  /// 商品详情页
//  static Future<void> goSkuDetailPage(SkuModel skuModel) {
//    return RouteHelper().pushWidget<void>(SkuDetailPage(skuModel));
//  }

}
