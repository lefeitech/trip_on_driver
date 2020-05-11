import 'package:driver/common/style/custom_theme.dart';
import 'package:flutter/material.dart';

/// 注册页面
class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Widget codeSuffix(String info) => Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Text(info, style: TextStyle(color: CustomTheme.of(context).tipAlertColor)),
    );


    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Container(),
    );
  }
}
// todo RegisterProvider
// todo 服务协议