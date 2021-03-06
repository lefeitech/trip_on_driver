import 'package:driver/common/enums/order.dart';
import 'package:driver/common/style/trip_on_icons.dart';
import 'package:driver/common/utils/navigator_util.dart';
import 'package:driver/pages/mine/car_info.dart';
import 'package:driver/pages/mine/my_infomation.dart';
import 'package:flutter/material.dart';

class MineInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final children = [
      _InfoItem(
        icon: TripOnIcons.order_copy,
        title: 'Completed Order',
        onPress: () {
          NavigatorUtil.goPartyOrderListPage(OrderState.done, title: 'Done');
        },
      ),
      // _InfoItem(
      //   icon: TripOnIcons.pingjia,
      //   title: '客户评价',
      //   onPress: () {},
      // ),
      _InfoItem(
        icon: TripOnIcons.gerenzhongxinwoderenwubiaozhuntouxianxing,
        title: 'Information',
        onPress: () {
          Navigator.pushNamed(context, MyInfomationPage.routeName);
        },
      ),
      _InfoItem(
        icon: TripOnIcons.car,
        title: 'Cars',
        onPress: () {
          Navigator.pushNamed(context, CarInfoPage.routeName);
        },
      ),
    ];

    return Container(
      margin: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        boxShadow: [
          BoxShadow(blurRadius: 5, color: Color(0x14A29E9E)),
        ],
      ),
      child: Column(children: _separateList(children)),
    );
  }

  List<Widget> _separateList(List<Widget> list) {
    final children = <Widget>[];
    final div = Divider(height: 1, indent: 20);
    list.forEach((child) {
      children.addAll([child, div]);
    });
    children.removeLast();
    return children;
  }
}

class _InfoItem extends StatelessWidget {
  _InfoItem(
      {Key key,
      @required this.icon,
      @required this.title,
      @required this.onPress})
      : assert(onPress != null),
        super(key: key);

  final IconData icon;
  final String title;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onPress,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            children: <Widget>[
              Icon(icon, size: 20),
              SizedBox(width: 12),
              Expanded(child: Text(title)),
              Icon(Icons.arrow_forward_ios, color: Colors.black12, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
