import 'dart:async';
import 'dart:io';
import 'package:driver/common/config/config.dart';
import 'package:driver/common/config/default_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';


class GlobalConfig with ChangeNotifier {
  static String _theme = DefaultConfig.theme;
  static String _language = DefaultConfig.language;
  static String _country = DefaultConfig.country;

  static Future<void> getDefaultConfig() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _theme = prefs.getString(Config.THEME_STYLE) ?? DefaultConfig.theme;
    _language = prefs.getString(Config.LANGUAGE) ?? DefaultConfig.language;
    _country = prefs.getString(Config.COUNTRY) ?? DefaultConfig.country;
  }

  static void setDefaultStatusBar() {
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }

  String getTheme() => _theme;

  String getLanguage() => _language;

  String getCountry() => _country;

  Future<void> setTheme(String theme) async {
    _theme = theme;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(Config.THEME_STYLE, theme);
    notifyListeners();
  }

  Future<void> setLocal(String language, String country) async {
    _language = language;
    _country = country;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(Config.LANGUAGE, language);
    prefs.setString(Config.COUNTRY, country);

    notifyListeners();
  }
}
