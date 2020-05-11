import 'package:driver/common/enums/auth.dart';
import 'package:driver/common/style/custom_theme.dart';
import 'package:driver/common/utils/navigator_util.dart';
import 'package:driver/pages/auth/register.dart';
import 'package:driver/pages/tab.dart';
import 'package:driver/shared_state/login_provider.dart';
import 'package:driver/shared_state/user_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  static const String routeName = 'login-page';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: ChangeNotifierProvider(
          create: (BuildContext context) => LoginProvider(context),
          child: Consumer<LoginProvider>(
            builder: (_, LoginProvider loginProvider, __) => _LoginForm(loginProvider),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  _LoginForm(this.provider);

  final LoginProvider provider;

  @override
  Widget build(BuildContext context) {
    String codeInfo = 'send code';
    if (provider.secondDec != 0) {
      codeInfo = 'send again(${provider.secondDec})';
    }

    Widget codeSuffix = Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Text(codeInfo, style: TextStyle(color: CustomTheme.of(context).tipAlertColor)),
    );

//    Widget shortDividerLine = Container(
//      width: 40,
//      height: .4,
//      decoration: BoxDecoration(border: Border(top: BorderSide(color: Theme.of(context).dividerColor))),
//    );

    return SafeArea(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text('快捷登录', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          Divider(height: 1, color: Color(0xFFE5E5E5)),
          SizedBox(height: 120),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              controller: provider.userNameCtrl,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(top: 14),
                prefixIcon: Icon(Icons.phone_iphone),
                hintText: 'please enter the phone number',
              ),
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              controller: provider.userPwdCtrl,
              obscureText: provider.loginMethod == LoginType.pwd,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(top: 14),
                prefixIcon: Icon(Icons.security),
                hintText:
                    provider.loginMethod == LoginType.code ? 'please enter verification code' : 'please enter password',
                suffixIcon: provider.loginMethod == LoginType.code
                    ? GestureDetector(
                        onTap: () {
                          if (provider.secondDec != 0) {
                            return;
                          }
                          provider.sendCode(context);
                        },
                        child: codeSuffix,
                      )
                    : null,
              ),
            ),
          ),
          SizedBox(height: 50),
          Container(
            width: double.infinity,
            height: 46,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: OutlineButton(
                    onPressed: provider.loginTypeChanged,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    child: Text(
                      provider.loginMethod == LoginType.code ? 'Password login' : 'Code login',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: FlatButton(
                    onPressed: () async {
                      final result = await provider.login(context);
                      if (result) {
                        /// save user info to [UserInfoProvider]
                        final userInfoProvider = Provider.of<UserInfoProvider>(context, listen: false);
                        userInfoProvider.userInfo = provider.userInfo;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (BuildContext context) => TabPage()),
                        );
                      }
                    },
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Login'),
                        SizedBox(width: 16),
                        Icon(Icons.arrow_forward, size: 20),
                      ],
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: FlatButton(
              child: Text('Register'),
              onPressed: NavigatorUtil.goRegisterStep1,
            ),
          )
//          Padding(
//            padding: const EdgeInsets.only(top: 12),
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                IconButton(
//                  icon: Icon(
//                    provider.agreed ? Icons.check_circle : Icons.radio_button_unchecked,
//                    color: CustomTheme.of(context).tipAlertColor,
//                    size: 16,
//                  ),
//                  onPressed: provider.agreeClicked,
//                ),
//                Flexible(
//                  child: Text.rich(
//                    TextSpan(
//                      text: 'read the ',
//                      style: Theme.of(context).textTheme.caption,
//                      children: [
//                        TextSpan(
//                          text: '\"User Services Agreement\"',
//                          style: TextStyle(color: CustomTheme.of(context).tipAlertColor),
//                        )
//                      ],
//                    ),
//                  ),
//                ),
//              ],
//            ),
//          ),
//            if (provider.isWxInstalled || Config.DEBUG) ...[
//              Expanded(child: Container()),
//              Row(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: <Widget>[
//                  shortDividerLine,
//                  Padding(
//                    padding: const EdgeInsets.symmetric(horizontal: 16),
//                    child: Text('第三方账号登录', style: Theme.of(context).textTheme.caption),
//                  ),
//                  shortDividerLine,
//                ],
//              ),
//              SizedBox(height: 16),
//              Center(
//                child: Container(
//                  width: 60,
//                  height: 60,
//                  decoration: BoxDecoration(
//                    shape: BoxShape.circle,
//                    border: Border.all(width: .4, color: Colors.grey[400]),
//                  ),
//                  child: IconButton(
//                    icon: Icon(ZGSIcons.icon_wechat, color: Theme.of(context).primaryColor, size: 40),
//                    onPressed: () {
//                      provider.wxLogin(context);
//                    },
//                  ),
//                ),
//              ),
//              SizedBox(height: 10),
//            ]
        ],
      ),
    );
  }
}
