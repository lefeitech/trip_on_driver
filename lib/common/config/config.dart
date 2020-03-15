import 'package:flutter/foundation.dart';

class Config {
  static bool get debugMode => !kReleaseMode;

  /// ////////////////////////////////////// 常量 //////////////////////////////////////
  static const TOKEN_KEY = "token";
  static const TOKEN_CREATE_TIME = "token-create-time";
  static const TOKEN_TIME_DIFF = "token-time-diff";
  static const USER_NAME_KEY = "user-name";
  static const USER_INFO = "user-info";
  static const THEME_STYLE = "theme-style";
  static const LANGUAGE = "language";
  static const COUNTRY = "country";

  /// ////////////////////////////////////// NETWORK常量 //////////////////////////////////////
  /// prod host
  static const String _PROD_STATION_HOST = 'https://station.zhigongshe.cn';
  static const String _PROD_SHOP_HOST = 'https://shop.zhigongshe.cn';

  /// test host
  static const String _DEV_STATION_HOST = 'http://teststation.zhigongshe.com';
  static const String _DEV_SHOP_HOST = 'http://testshop.zhigongshe.com';


  /// ////////////////////////////////////// sentry appid //////////////////////////////////////
  static const String SENTRY_DSN = 'https://8e5a2bddff834adeaf1f5ed550cbddbf@sentry.io/4784190';

  /// ////////////////////////////////////// getter //////////////////////////////////////
  static String get host => debugMode ? _DEV_STATION_HOST : _PROD_STATION_HOST;

//  static String get stationHost => false ? _DEV_STATION_HOST : _PROD_STATION_HOST;


}