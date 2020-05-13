import 'dart:io';
import 'package:driver/shared_state/register_provider.dart';
import 'package:driver/widgets/info_photo_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 注册页面 步骤三
class RegisterStep3Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Consumer<RegisterProvider>(
        builder: (_, RegisterProvider provider, __) => Step3form(provider),
      ),
    );
  }
}
// todo RegisterProvider
// todo 服务协议

class Step3form extends StatelessWidget {
  Step3form(this.provider);

  final RegisterProvider provider;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 50) ,
          child: InfoPhotoPicker(
            title: 'Positive',
            onFileChanged: (File image) {
              provider.card1 = image;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 50) ,
          child: InfoPhotoPicker(
            title: 'Back',
            onFileChanged: (File image) {
              provider.card2 = image;
            },
          ),
        ),

      ],
    );
  }
}
