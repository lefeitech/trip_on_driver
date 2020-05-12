import 'package:driver/common/style/custom_theme.dart';
import 'package:driver/common/utils/validators.dart';
import 'package:driver/shared_state/register_provider.dart';
import 'package:driver/widgets/bottom_with_one_btn.dart';
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
    Widget codeSuffix(String info) => GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(top: 14),
        child: Text(info, style: TextStyle(color: CustomTheme.of(context).tipAlertColor)),
      ),
      onTap: provider.sendCode,
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
                validator: Validators.required('Name is required'),
              ),
              TextFormField(
                controller: provider.enNameCtrl,
                decoration: InputDecoration(
                  labelText: 'English Name',
                  hintText: 'English Name',
                ),
                validator: Validators.required('English name is required'),
              ),
              TextFormField(
                controller: provider.telCtrl,
                decoration: InputDecoration(
                  labelText: 'Phone number',
                  hintText: 'Phone number',
                  suffixIcon: codeSuffix(provider.getCodeStr(context)),
                ),
                validator: Validators.required('Phone number is required'),
              ),
              TextFormField(
                controller: provider.codeCtrl,
                decoration: InputDecoration(
                  labelText: 'Verify code',
                  hintText: 'Verify code',
                ),
                validator: Validators.required('Verify code is required'),
              ),
              TextFormField(
                controller: provider.pwdCtrl,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Password',
                ),
                validator: Validators.required('Password is required'),
              ),
              TextFormField(
                controller: provider.rePwdCtrl,
                decoration: InputDecoration(
                  labelText: 'Re-Password',
                  hintText: 'Re-Password',
                ),
                validator: (String pwd) {
                  final result = Validators.required('Password is required')(pwd);
                  return result ?? Validators.same(provider.pwdCtrl.text, 'Passwords entered twice are different')(pwd);
                },
              ),
              TextFormField(
                controller: provider.cardCtrl,
                decoration: InputDecoration(
                  labelText: 'Driver\'s license number',
                  hintText: 'Driver\'s license number',
                ),
                validator: Validators.required('Driver\'s license number is required'),
              ),
              TextFormField(
                controller: provider.emailCtrl,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Email',
                ),
                validator: (String email) {
                  final result = Validators.required('Email is required')(email);
                  return result ?? Validators.email('Email format is incorrect')(email);
                },
              ),
              TextFormField(
                controller: provider.bankNoCtrl,
                decoration: InputDecoration(
                  labelText: 'Bank Number',
                  hintText: 'Bank Number',
                ),
                validator: Validators.required('Bank Number is required'),
              ),
              TextFormField(
                controller: provider.tel2Ctrl,
                decoration: InputDecoration(
                  labelText: 'Emergency contact\'s number',
                  hintText: 'Emergency contact\'s number',
                ),
                validator: Validators.required('Emergency contact\'s number is required'),
              ),
              SizedBox(height: 16),
              BottomWithOneBtn(
                onPress: provider.saveStep1,
                padding: const EdgeInsets.all(0),
                child: Text('Next step'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
