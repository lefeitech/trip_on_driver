import 'dart:async';
import 'package:driver/app.dart';
import 'package:driver/common/report/report.dart';
import 'package:driver/shared_state/global_config.dart';
import 'package:driver/shared_state/push_service.dart';
import 'package:driver/shared_state/tab_provider.dart';
import 'package:driver/shared_state/user_info.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

Future<Null> main() async {
  FlutterError.onError = (FlutterErrorDetails details) async {
    reportError(details.exception, details.stack);
  };

  Future<void> _runApp() async {
    WidgetsFlutterBinding.ensureInitialized();

    await GlobalConfig.getDefaultConfig();
    await PushService.init();
    GlobalConfig.setDefaultStatusBar();

    runApp(OKToast(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => GlobalConfig()),
          ChangeNotifierProvider(create: (_) => UserInfoProvider()),
          ChangeNotifierProvider(create: (_) => TabProvider()),
          ChangeNotifierProvider(create: (_) => PushService()),
        ],
        child: DriverApp(),
      ),
    ));
  }

  runZonedGuarded<Future<void>>(_runApp, reportError);
}
