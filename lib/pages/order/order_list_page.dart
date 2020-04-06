import 'package:driver/common/enums/order.dart';
import 'package:driver/pages/order/order_list_item.dart';
import 'package:driver/pages/order/order_detail.dart';
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
                  OrderList(status: OrderStatus.pending),
                  OrderList(status: OrderStatus.done),
                  OrderList(status: OrderStatus.canceled),
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
      height: 95,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(blurRadius: 10, color: Color(0x14959192))],
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: TabBar(
          controller: controller,
          tabs: <Widget>[
            Tab(text: '待服务'),
            Tab(text: '已完成'),
            Tab(text: '已取消'),
          ],
          labelColor: Color(0xFF222222),
          labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
            insets: const EdgeInsets.only(bottom: 16),
          ),
        ),
      ),
    );
  }
}

class OrderList extends StatelessWidget {
  OrderList({this.status});

  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => OrderListItem(onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => OrderDetailPage()));
      },),
    );
  }
}
