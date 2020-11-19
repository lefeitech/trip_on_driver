import 'dart:io';
import 'package:driver/common/style/custom_theme.dart';
import 'package:driver/common/utils/validators.dart';
import 'package:driver/shared_state/register_provider.dart';
import 'package:driver/widgets/bottom_with_one_btn.dart';
import 'package:driver/widgets/info_photo_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

/// 注册页面 步骤三
class RegisterStep3Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Consumer<RegisterProvider>(
        builder: (_, RegisterProvider provider, __) =>
            FlutterEasyLoading(child: Step3form(provider)),
      ),
    );
  }
}

class Step3form extends StatelessWidget {
  Step3form(this.provider);

  final RegisterProvider provider;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 50),
          child: InfoPhotoPicker(
            title: 'Positive',
            initImage: provider.carsImage[0],
            onFileChanged: (File image) {
              provider.carsImage[0] = image;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 50),
          child: InfoPhotoPicker(
            title: 'Back',
            initImage: provider.carsImage[1],
            onFileChanged: (File image) {
              provider.carsImage[1] = image;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 50),
          child: InfoPhotoPicker(
            title: 'Side',
            initImage: provider.carsImage[2],
            onFileChanged: (File image) {
              provider.carsImage[2] = image;
            },
          ),
        ),
        TextFormField(
          controller: provider.carNo,
          decoration: InputDecoration(
            labelText: 'Car\'s number',
            hintText: 'Car\'s number',
          ),
          validator: Validators.required('Car\'s number is required'),
        ),
        TextFormField(
          controller: provider.carMake,
          decoration: InputDecoration(
            labelText: 'Vehicle Brands',
            hintText: 'Vehicle Brands',
          ),
          validator: Validators.required('Vehicle Brands is required'),
        ),
        TextFormField(
          controller: provider.carColor,
          decoration: InputDecoration(
            labelText: 'Color',
            hintText: 'Color',
          ),
          validator: Validators.required('Please input car\'s color'),
        ),
        TextFormField(
          controller: provider.carNum,
          decoration: InputDecoration(
            labelText: 'Number of seats',
            hintText: 'Number of seats',
          ),
          validator: Validators.required('Please input Number of seats'),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  provider.agreed
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  color: CustomTheme.of(context).tipAlertColor,
                  size: 16,
                ),
                onPressed: provider.agreeClicked,
              ),
              Flexible(
                child: Text.rich(
                  TextSpan(
                    text: 'read the ',
                    style: Theme.of(context).textTheme.caption,
                    children: [
                      TextSpan(
                        text: '\"User Services Agreement\"',
                        style: TextStyle(
                            color: CustomTheme.of(context).tipAlertColor),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        BottomWithOneBtn(
          onPress: () {
            provider.finish(context);
          },
          padding: const EdgeInsets.all(0),
          child: Text('Finish'),
        ),
      ],
    );
  }
}
