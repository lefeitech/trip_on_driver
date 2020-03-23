import 'dart:async';
import 'package:driver/app.dart';
import 'package:driver/common/report/report.dart';
import 'package:driver/shared_state/global_config.dart';
import 'package:driver/shared_state/tab_provider.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

Future<Null> main() async {
  FlutterError.onError = (FlutterErrorDetails details) async {
    reportError(details.exception, details.stack);
  };

  runZoned<Future<Null>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await GlobalConfig.getDefaultConfig();
    GlobalConfig.setDefaultStatusBar();

    runApp(OKToast(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => GlobalConfig()),
          ChangeNotifierProvider(create: (_) => TabProvider()),
        ],
        child: DriverApp(),
      ),
    ));
  }, onError: (error, stackTrace) async {
    await reportError(error, stackTrace);
  });
}
