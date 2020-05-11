import 'package:driver/common/style/custom_theme.dart';
import 'package:driver/shared_state/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 注册页面 步骤一
class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Consumer<RegisterProvider>(
        builder: (_, RegisterProvider provider, __) => Step1form(provider),
      ),
    );
  }
}

class Step1form extends StatelessWidget {
  Step1form(this.provider);

  final RegisterProvider provider;

  @override
  Widget build(BuildContext context) {
    Widget codeSuffix(String info) => Padding(
          padding: const EdgeInsets.only(top: 14),
          child: Text(info, style: TextStyle(color: CustomTheme.of(context).tipAlertColor)),
        );

    return Container(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Form(
          key: provider.step1key,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: provider.nameCtrl,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  hintText: 'Full Name',
                ),
              ),
              TextFormField(
                controller: provider.enNameCtrl,
                decoration: InputDecoration(
                  labelText: 'English Name',
                  hintText: 'English Name',
                ),
              ),
              TextFormField(
                controller: provider.telCtrl,
                decoration: InputDecoration(
                  labelText: 'Phone number',
                  hintText: 'Phone number',
                  suffixIcon: codeSuffix('send code'),
                ),
              ),
              TextFormField(
                controller: provider.codeCtrl,
                decoration: InputDecoration(
                  labelText: 'Verify code',
                  hintText: 'Verify code',
                ),
              ),
              TextFormField(
                controller: provider.pwdCtrl,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Password',
                ),
              ),
              TextFormField(
                controller: provider.rePwdCtrl,
                decoration: InputDecoration(
                  labelText: 'Re-Password',
                  hintText: 'Re-Password',
                ),
              ),
              TextFormField(
                controller: provider.cardCtrl,
                decoration: InputDecoration(
                  labelText: 'Driver\'s license number',
                  hintText: 'Driver\'s license number',
                ),
              ),
              TextFormField(
                controller: provider.emailCtrl,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Email',
                ),
              ),
              TextFormField(
                controller: provider.bankNoCtrl,
                decoration: InputDecoration(
                  labelText: 'Bank Number',
                  hintText: 'Bank Number',
                ),
              ),
              TextFormField(
                controller: provider.tel2Ctrl,
                decoration: InputDecoration(
                  labelText: 'emergency contact\'s number',
                  hintText: 'emergency contact\'s number',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// todo RegisterProvider
// todo 服务协议
