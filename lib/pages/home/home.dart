import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:driver/common/model/order/rob_list_res.dart';
import 'package:driver/common/network/common_http.dart';
import 'package:driver/common/utils/common_util.dart';
import 'package:driver/pages/rob/rob_list_item.dart';
import 'package:driver/pages/rob/rob_list_repo.dart';
import 'package:driver/shared_state/user_info.dart';
import 'package:driver/widgets/data_indicators.dart';
import 'package:driver/widgets/load_more_list_indicators.dart';
import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:provider/provider.dart';
import '../../common/network/base_url.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Order grabbing')),
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

  grab(driver, id) async {
    CommonUtils.showMessage('Grabbing...');
    Response res = await CommonHttp().post(
      BaseUrl.robState,
      data: {'order_id': id, 'driver_id': driver},
    );
    var code = jsonDecode(res.toString())['code'];
    print(code);
    if (code == 1) {
      CommonUtils.showMessage('Grab Success!');
      _repo.refresh();
    } else {
      CommonUtils.showMessage('Grab Failed!');
    }
  }

  Widget _itemBuilder(BuildContext context, RobInfo item, int index) =>
      RobListItem(item);

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
