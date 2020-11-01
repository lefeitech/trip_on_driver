import 'package:driver/common/model/order/rob_list_res.dart';
import 'package:driver/common/utils/navigator_util.dart';
import 'package:driver/pages/rob/rob_list_item.dart';
import 'package:driver/pages/rob/rob_list_repo.dart';
import 'package:driver/shared_state/user_info.dart';
import 'package:driver/widgets/data_indicators.dart';
import 'package:driver/widgets/load_more_list_indicators.dart';
import 'package:driver/widgets/main_container.dart';
import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Order grabbing')),
      body: MainContainer(
        child: Consumer<UserInfoProvider>(
          builder: (_, UserInfoProvider userInfoProvider, __) =>
              OrderList(driverId: userInfoProvider.userInfo?.id),
        ),
      ),
    );
  }
}

class OrderList extends StatefulWidget {
  OrderList({this.driverId});

  final int driverId;

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  final _repo = RobListRepo();
  List robs = [];

  @override
  void didUpdateWidget(OrderList oldWidget) {
    super.didUpdateWidget(oldWidget);
    _repo.driverId = widget.driverId.toString();
  }

  @override
  void initState() {
    super.initState();
    _repo.driverId = widget.driverId.toString();
  }

  @override
  void dispose() {
    super.dispose();
    _repo.dispose();
  }

  Widget _itemBuilder(BuildContext context, RobInfo item, int index) =>
      RobListItem(
        item,
        onTap: () => NavigatorUtil.goRobDetailPage(item),
        success: _repo.refresh,
        failed: _repo.refresh,
      );

  @override
  Widget build(BuildContext context) {
    if (widget.driverId == null) {
      return LoadingWidget(isFullPage: true);
    }
    ListConfig config = ListConfig<RobInfo>(
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
