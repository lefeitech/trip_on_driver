import 'package:driver/common/utils/common_util.dart';
import 'package:driver/shared_state/user_info.dart';
import 'package:driver/widgets/to_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyInfomationPage extends StatelessWidget {
  static const String routeName = 'my-info-page';

  Widget _buildItem(BuildContext context, {String label, String value}) {
    return Row(
      children: [
        SizedBox(width: 100, child: Text(label)),
        Text(value, style: Theme.of(context).textTheme.caption)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Infomation'), centerTitle: true),
      body: Consumer<UserInfoProvider>(
        child: Divider(),
        builder: (_, infoProvider, child) => SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              TOCard(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                child: Column(
                  children: [
                    _buildItem(
                      context,
                      label: 'Name',
                      value: infoProvider.userInfo.driverName,
                    ),
                    child,
                    _buildItem(
                      context,
                      label: 'Tel',
                      value: CommonUtils.formatHiddenPhone(
                          infoProvider.userInfo.driverTel),
                    ),
                    child,
                    _buildItem(
                      context,
                      label: 'Emal',
                      value: infoProvider.userInfo.email,
                    ),
                    child,
                    _buildItem(
                      context,
                      label: 'Bank No.',
                      value: infoProvider.userInfo.bankNo,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
