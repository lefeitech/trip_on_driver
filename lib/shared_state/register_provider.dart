import 'package:flutter/material.dart';

class RegisterProvider with ChangeNotifier {



  final step1key = GlobalKey<FormState>();
  final step2key = GlobalKey<FormState>();
  final step3key = GlobalKey<FormState>();

  // full name
  final nameCtrl = TextEditingController();
  // en-name
  final enNameCtrl = TextEditingController();
  // phone number
  final telCtrl = TextEditingController();
  // sms verify code
  final codeCtrl = TextEditingController();
  final pwdCtrl = TextEditingController();
  final rePwdCtrl = TextEditingController();
  // driver's license
  final cardCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final weChatCtrl = TextEditingController();
  final bankNoCtrl = TextEditingController();
  // emergency contact's phone number
  final tel2Ctrl = TextEditingController();
}