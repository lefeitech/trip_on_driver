import 'package:driver/common/enums/config.dart';
import 'package:driver/shared_state/global_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _primaryRed = const Color(0xFFF66139);

/// 自定义样式
class CustomTheme {
  static double get separationHeight => 16;

  final Color cardShadowColor;
  final Color settingCardShadowColor;
  final Color settingCardColorBegin;
  final Color settingCardColorEnd;
  final InputBorder inputErrorBorder;
  final Color tipMainColor;
  final Color tipAlertColor;

  CustomTheme({
    this.cardShadowColor,
    this.settingCardShadowColor,
    this.settingCardColorBegin,
    this.settingCardColorEnd,
    this.inputErrorBorder = const OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.red)),
    this.tipMainColor = const Color(0xFF3CBF0D),
    this.tipAlertColor = _primaryRed,
  });

  factory CustomTheme.light() {
    return CustomTheme(
      cardShadowColor: Colors.grey[300],
      settingCardShadowColor: Colors.black12,
      settingCardColorBegin: Colors.lightBlueAccent,
      settingCardColorEnd: Colors.blue,
    );
  }

  factory CustomTheme.dark() {
    return CustomTheme(
      cardShadowColor: Colors.black12,
      settingCardShadowColor: Colors.black12,
      settingCardColorBegin: Colors.grey[800],
      settingCardColorEnd: Colors.black54,
    );
  }

  /// could get theme use this method
  static CustomTheme of(BuildContext context) {
    GlobalConfig globalConfig = Provider.of<GlobalConfig>(context, listen: false);
    String theme = globalConfig.getTheme();
    return theme == ThemeEnums.light ? CustomTheme.light() : CustomTheme.dark();
  }

  /// get system theme, typically use in initialize app
  static ThemeData getSystemTheme(BuildContext context) {
    GlobalConfig globalConfig = Provider.of<GlobalConfig>(context, listen: false);
    String theme = globalConfig.getTheme();
    return theme == ThemeEnums.light ? CustomTheme.lightTheme() : CustomTheme.darkTheme();
  }

  /// 亮色/暗色主题
  static ThemeData lightTheme() {
    return ThemeData.light().copyWith(
      primaryColor: Color(0xFF00AFFF),
      primaryColorLight: Color(0xFF00CFFF),
      accentColor: Color(0xFF00CFFF),
      appBarTheme: AppBarTheme(elevation: 0),
      scaffoldBackgroundColor: Color(0xFFEEEEEE),
      toggleableActiveColor: _primaryRed,
      dividerColor: Color(0xFFEEEEEE),
      textTheme: ThemeData.light().textTheme.copyWith(
            caption: TextStyle(color: Color(0xFF999999), fontSize: 12),
          ),
      tabBarTheme: ThemeData.light().tabBarTheme.copyWith(
            indicatorSize: TabBarIndicatorSize.label,
            indicator: UnderlineTabIndicator(insets: const EdgeInsets.only(bottom: 6)),
          ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData.dark().copyWith(
      appBarTheme: AppBarTheme(elevation: 0),
      textTheme: ThemeData.light().textTheme.copyWith(caption: TextStyle(fontSize: 12)),
      tabBarTheme: ThemeData.dark().tabBarTheme.copyWith(
            indicatorSize: TabBarIndicatorSize.label,
            indicator: UnderlineTabIndicator(insets: const EdgeInsets.only(bottom: 6)),
          ),
    );
  }
}
