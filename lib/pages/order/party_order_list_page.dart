import 'package:driver/common/enums/order.dart';
import 'package:driver/shared_state/user_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'order_list_page.dart';

// order list without tab

class PartyOrderListPage extends StatelessWidget {
  PartyOrderListPage({
    @required this.state,
    this.title = '',
  });

  final int state;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? ''),
        centerTitle: true,
      ),
      body: Consumer<UserInfoProvider>(
        builder: (_, provider, __) => OrderList(
          status: OrderState.done,
          driverId: provider.userInfo?.id,
        ),
      ),
    );
  }
}
