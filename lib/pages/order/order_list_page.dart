import 'package:driver/common/enums/order.dart';
import 'package:driver/common/model/order/order_detail.dart';
import 'package:driver/common/utils/navigator_util.dart';
import 'package:driver/pages/order/order_list_item.dart';
import 'package:driver/pages/order/order_list_repo.dart';
import 'package:driver/shared_state/user_info.dart';
import 'package:driver/widgets/data_indicators.dart';
import 'package:driver/widgets/load_more_list_indicators.dart';
import 'package:driver/widgets/main_container.dart';
import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:provider/provider.dart';

class OrderListPage extends StatefulWidget {
  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage>
    with SingleTickerProviderStateMixin {
  TabController _tabCtrl;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(vsync: this, length: 4);
  }

  @override
  void dispose() {
    super.dispose();
    _tabCtrl?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Center'),
        centerTitle: true,
      ),
      body: MainContainer(
        child: Column(
          children: <Widget>[
            OrderListTab(controller: _tabCtrl),
            Expanded(
              child: Consumer<UserInfoProvider>(
                builder: (_, UserInfoProvider userInfoProvider, __) =>
                    TabBarView(
                  controller: _tabCtrl,
                  children: <Widget>[
                    OrderList(
                      status: OrderState.picked,
                      driverId: userInfoProvider.userInfo?.id,
                    ),
                    OrderList(
                      status: OrderState.passengerOnBoard,
                      driverId: userInfoProvider.userInfo?.id,
                    ),
                    OrderList(
                      status: OrderState.done,
                      driverId: userInfoProvider.userInfo?.id,
                    ),
                    OrderList(
                      status: OrderState.canceled,
                      driverId: userInfoProvider.userInfo?.id,
                    ),
                  ],
                ),
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
          isScrollable: true,
          controller: controller,
          tabs: <Widget>[
            Tab(text: 'Accepted'),
            Tab(text: 'Picked Up'),
            Tab(text: 'Completed'),
            Tab(text: 'Cancelled'),
          ],
          labelColor: Color(0xFF222222),
          labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
              width: 3,
              color: Theme.of(context).primaryColor,
            ),
            insets: const EdgeInsets.only(bottom: 16),
          ),
        ),
      ),
    );
  }
}

class OrderList extends StatefulWidget {
  OrderList({this.status, this.driverId});

  final int status;
  final int driverId;

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  final _repo = OrderListRepo();

  @override
  void didUpdateWidget(OrderList oldWidget) {
    super.didUpdateWidget(oldWidget);
    _repo.orderStatus = widget.status;
    _repo.driverId = widget.driverId.toString();
  }

  @override
  void initState() {
    super.initState();
    _repo.orderStatus = widget.status;
    _repo.driverId = widget.driverId.toString();
  }

  Widget _itemBuilder(BuildContext context, OrderInfoModel item, int index) =>
      OrderListItem(
        item,
        onTap: () {
          NavigatorUtil.goOrderDetailPage(item);
        },
      );

  @override
  Widget build(BuildContext context) {
    if (widget.driverId == null) {
      return LoadingWidget(isFullPage: true);
    }
    ListConfig config = ListConfig<OrderInfoModel>(
      padding: EdgeInsets.zero,
      sourceList: _repo,
      indicatorBuilder:
          ListStatus(context: context, repo: _repo).indicatorBuilder,
      itemBuilder: _itemBuilder,
    );
    return RefreshIndicator(
      onRefresh: _repo.refresh,
      child: LoadingMoreList(config),
    );
  }
}
