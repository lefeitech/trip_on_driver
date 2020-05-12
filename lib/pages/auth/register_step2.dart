import 'package:driver/common/style/custom_theme.dart';
import 'package:driver/shared_state/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 注册页面 步骤二
class RegisterStep2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Consumer<RegisterProvider>(
        builder: (_, RegisterProvider provider, __) => Step2form(provider),
      ),
    );
  }
}
// todo RegisterProvider
// todo 服务协议

class Step2form extends StatelessWidget {
  Step2form(this.provider);

  final RegisterProvider provider;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
