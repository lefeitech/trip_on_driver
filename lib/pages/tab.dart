import 'package:driver/common/style/trip_on_icons.dart';
import 'package:driver/pages/home/home.dart';
import 'package:driver/pages/message/message.dart';
import 'package:driver/pages/mine/mine.dart';
import 'package:driver/pages/order/order_list_page.dart';
import 'package:driver/shared_state/tab_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabPage extends StatelessWidget {
  final _tabs = [
    HomePage(),
    // MessagePage(),
    OrderListPage(),
    MinePage(),
  ];

  static const String routeName = 'tab-page';

  @override
  Widget build(BuildContext context) {
    return Consumer<TabProvider>(
      builder: (BuildContext context, TabProvider tabProvider, _) => Scaffold(
        body: IndexedStack(index: tabProvider.index, children: _tabs),
        bottomNavigationBar: DecoratedBox(
          decoration: BoxDecoration(boxShadow: [BoxShadow(blurRadius: 13.3, color: Color(0x32A29E9E))]),
          child: BottomNavigationBar(
            currentIndex: tabProvider.index,
            showUnselectedLabels: true,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            items: _buildNavigationItem(context),
            onTap: tabProvider.changeTab,
          ),
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> _buildNavigationItem(BuildContext context) {
    final TextStyle textStyle = TextStyle(fontSize: 12);
    return [
      BottomNavigationBarItem(
        title: Text('Home', style: textStyle),
        icon: Icon(TripOnIcons.shouye2),
        activeIcon: Icon(TripOnIcons.shouye1),
      ),
      // BottomNavigationBarItem(
      //   title: Text('Message', style: textStyle),
      //   icon: Icon(TripOnIcons.xiaoxi),
      // ),
      BottomNavigationBarItem(
        title: Text('Order', style: textStyle),
        icon: Icon(TripOnIcons.order_copy),
      ),
      BottomNavigationBarItem(
        title: Text('My', style: textStyle),
        icon: Icon(TripOnIcons.wode1),
        activeIcon: Icon(TripOnIcons.wode2),
      ),
    ];
  }
}
