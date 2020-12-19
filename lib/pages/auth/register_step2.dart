import 'dart:io';
import 'package:driver/shared_state/register_provider.dart';
import 'package:driver/widgets/bottom_with_one_btn.dart';
import 'package:driver/widgets/info_photo_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 注册页面 步骤二
class RegisterStep2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Personal information')),
      body: Consumer<RegisterProvider>(
        builder: (_, RegisterProvider provider, __) => Step2form(provider),
      ),
    );
  }
}

class Step2form extends StatelessWidget {
  Step2form(this.provider);

  final RegisterProvider provider;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 50),
          child: InfoPhotoPicker(
            title: 'IC PHOTO',
            initImage: provider.card1,
            onFileChanged: (File image) {
              provider.card1 = image;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 50),
          child: InfoPhotoPicker(
            title: 'LICENSE PHOTO',
            initImage: provider.card2,
            onFileChanged: (File image) {
              provider.card2 = image;
            },
          ),
        ),
        BottomWithOneBtn(
          onPress: provider.saveStep2,
          padding: const EdgeInsets.all(0),
          child: Text('Next step'),
        ),
      ],
    );
  }
}
