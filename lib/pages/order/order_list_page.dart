import 'package:driver/common/enums/order.dart';
import 'package:driver/common/style/custom_theme.dart';
import 'package:driver/widgets/start_arrive_widget.dart';
import 'package:driver/widgets/to_card.dart';
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
      itemBuilder: (BuildContext context, int index) => OrderListItem(),
    );
  }
}

class OrderListItem extends StatelessWidget {
  final _bodyFontColor = Color(0xFFA2A0A0);

  @override
  Widget build(BuildContext context) {
    return TOCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // order title / time / no.
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('接机', style: Theme.of(context).textTheme.subtitle.copyWith(fontSize: 18)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    const SizedBox(height: 10),
                    Text('2020-03-01 08:24', style: TextStyle(color: _bodyFontColor, fontSize: 12)),
                    const SizedBox(height: 2),
                    Text('No.009620200301', style: TextStyle(color: _bodyFontColor, fontSize: 10)),
                  ],
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 6, bottom: 6, right: 10),
                child: Icon(Icons.cloud_circle, color: _bodyFontColor, size: 20),
              ),
              Text(' AE86E86 航班实际到达后用车', style: TextStyle(color: _bodyFontColor, fontSize: 12)),
            ],
          ),
          // start point and arrive point
          StartArriveWidget(title: '吉隆坡国际机场（吉隆坡）'),
          StartArriveWidget(title: '马来西亚国际伊斯兰大学', isStart: false),
          SizedBox(height: 20),
          // sum
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text.rich(
              TextSpan(
                text: '总额：￥',
                style: TextStyle(color: _bodyFontColor, fontSize: 12),
                children: [
                  TextSpan(
                    text: '850',
                    style: TextStyle(
                      color: CustomTheme.of(context).tipAlertColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
