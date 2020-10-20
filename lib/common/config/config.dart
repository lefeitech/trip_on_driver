import 'package:flutter/foundation.dart';

class Config {
  static bool get debugMode => !kReleaseMode;

  /// ////////////////////////////////////// 常量 //////////////////////////////////////
  static const TOKEN_KEY = "token";
  static const TOKEN_CREATE_TIME = "token-create-time";
  static const TOKEN_TIME_DIFF = "token-time-diff";
  static const USER_NAME_KEY = "user-name";
  static const USER_INFO = "user-info";
  static const USER_ID = "user-id";
  static const VERIFY_STATUS = "verify-status";
  static const THEME_STYLE = "theme-style";
  static const LANGUAGE = "language";
  static const COUNTRY = "country";

  /// ////////////////////////////////////// NETWORK常量 //////////////////////////////////////
  /// prod host
  static const String _PROD_HOST = 'https://tripapi.ldbro.com';

  /// test host
  static const String _DEV_HOST = 'https://tripapi.ldbro.com';

  /// ////////////////////////////////////// sentry appid //////////////////////////////////////
  static const String SENTRY_DSN = 'https://8e5a2bddff834adeaf1f5ed550cbddbf@sentry.io/4784190';

  /// ////////////////////////////////////// http client key secret //////////////////////////////////////
  static const String HTTP_VERSION = 'v2';
  static const String HTTP_KEY = 'driver';
  static const String HTTP_SECRET = 'qwertyuiopasdfghjklzxcvbnm123';

  /// ////////////////////////////////////// sentry appid //////////////////////////////////////
  static const String TEST_ACCOUNT = '18419064455';
  static const String TEST_PWD = '727322';

  /// ////////////////////////////////////// getter //////////////////////////////////////
  static String get host => debugMode ? _DEV_HOST : _PROD_HOST;

//  static String get host => false ? _DEV_STATION_HOST : _PROD_STATION_HOST;

}
