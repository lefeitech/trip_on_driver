import 'package:flutter/material.dart';

class OrderListPage extends StatefulWidget {
  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> with SingleTickerProviderStateMixin {
  TabController _tabCtrl;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    super.dispose();
    _tabCtrl?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('订单中心')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor,
              Color(0xFFF7F7FF),
              Color(0xFFF7F7FF),
            ],
            stops: [0, 0.33, 1],
          ),
        ),
        child: Column(
          children: <Widget>[
            OrderListTab(controller: _tabCtrl),
            Expanded(
              child: TabBarView(
                controller: _tabCtrl,
                children: <Widget>[
                  OrderList(),
                  OrderList(),
                  OrderList(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OrderListTab extends StatelessWidget {
  OrderListTab({this.controller});

  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      child: TabBar(
        controller: controller,
        tabs: <Widget>[
          Tab(text: '待服务'),
          Tab(text: '已完成'),
          Tab(text: '已取消'),
        ],
        labelColor: Color(0xFF222222),
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
        indicatorColor: Theme.of(context).primaryColor,
        indicatorPadding: EdgeInsets.only(bottom: 4),
        indicatorWeight: 4,
        indicatorSize: TabBarIndicatorSize.label,
      ),
    );
  }
}

class OrderList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: Icon(Icons.ac_unit));
  }
}
