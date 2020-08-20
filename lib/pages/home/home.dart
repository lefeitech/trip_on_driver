import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:driver/common/enums/order.dart';
import 'package:driver/common/model/order/order_detail.dart';
import 'package:driver/common/model/order/order_list_res.dart';
import 'package:driver/common/network/common_http.dart';
import 'package:driver/common/style/custom_theme.dart';
import 'package:driver/common/style/trip_on_icons.dart';
import 'package:driver/common/utils/common_util.dart';
import 'package:driver/common/utils/navigator_util.dart';
import 'package:driver/common/utils/order.dart';
import 'package:driver/pages/order/order_list_item.dart';
import 'package:driver/pages/order/order_list_repo.dart';
import 'package:driver/shared_state/user_info.dart';
import 'package:driver/widgets/data_indicators.dart';
import 'package:driver/widgets/load_more_list_indicators.dart';
import 'package:driver/widgets/start_arrive_widget.dart';
import 'package:driver/widgets/to_card.dart';
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
              builder: (_, UserInfoProvider userInfoProvider, __) => OrderList(driverId: userInfoProvider.userInfo?.id)
            )
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
  final _repo = OrderListRepo();
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
    getData();
  }

  Future<void> getData() async {
    Response robs = await CommonHttp().get(BaseUrl.robList);
    try {
      this.setState(() {
        // print(jsonDecode(robs.toString())['data']['info']);
        this.robs = jsonDecode(robs.toString())['data']['info'];
      });
    } catch (e) {
      print(e);
    }
  }

  grab(driver, id) async {
    CommonUtils.showMessage('Grabbing...');
    Response res = await CommonHttp().post(BaseUrl.robState, data: {'order_id': id, 'driver_id': driver},);
    var code = jsonDecode(res.toString())['code'];
    print(code);
    if(code==1) {
      CommonUtils.showMessage('Grab Success!');
      await getData();
    }else{
      CommonUtils.showMessage('Grab Failed!');
    }
  }

  final _bodyFontColor = Color(0xFFA2A0A0);

  @override
  Widget build(BuildContext context) {

    if (widget.driverId == null) {
      return LoadingWidget(isFullPage: true);
    }

    // if (this.robs.length==0) {
    //   return Container(
    //     margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
    //     child: NoDataWidget()
    //   );
    // }

    return RefreshIndicator(
      onRefresh: getData,
      child: ListView.builder(
        padding: EdgeInsets.fromLTRB(8, 16, 8, 0),
        itemCount: this.robs.length,
        itemBuilder: (BuildContext context, int index) {
          var info = this.robs[index];
          final id = info['id'].toString();
          final outTradeNo = info['out_trade_no'];
          final flight = info['other']['flight'];
          final type = info['other']['type'];
          final destination = info['other']['destination'];
          final airport = info['other']['airport'];
          final payTotalMoney = info['pay_total_money'];

          final transformType = OrderUtil.mapTransformType(info['other']['type']);
          return GestureDetector(
            // onTap: onTap ?? () {},
            child: TOCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // order title / time / no.
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(transformType, style: Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 18)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            const SizedBox(height: 10),
                            Text(info['create_time'] ?? '', style: TextStyle(color: _bodyFontColor, fontSize: 12)),
                            const SizedBox(height: 2),
                            Text('No.$outTradeNo', style: TextStyle(color: _bodyFontColor, fontSize: 10)),
                          ],
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 6, bottom: 6, right: 10),
                        child: Icon(TripOnIcons.shijian, color: _bodyFontColor, size: 20),
                      ),
                      Text('$flight', style: TextStyle(color: _bodyFontColor, fontSize: 12)),
                    ],
                  ),
                  // start point and arrive point
                  if (type == TransformType.pickUp) ...[
                    StartArriveWidget(title: Text(airport)),
                    StartArriveWidget(title: Text(destination), isStart: false),
                  ] else ...[
                    StartArriveWidget(title: Text(destination)),
                    StartArriveWidget(title: Text(airport), isStart: false),
                  ],

                  SizedBox(height: 20),
                  // sum
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text.rich(
                          TextSpan(
                            text: 'lump sum：￥',
                            style: TextStyle(color: _bodyFontColor, fontSize: 12),
                            children: [
                              TextSpan(
                                text: '${payTotalMoney ?? ''}',
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
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: Color(0xFF2096F3),
                          boxShadow: [ //阴影
                            BoxShadow(
                              color: Color(0xFF4faff8),
                              offset: Offset(0, 2),
                              blurRadius: 4.0
                            )
                          ],
                          borderRadius: BorderRadius.circular(30.0)
                        ),
                        child: FlatButton(
                          textColor: Colors.white,
                          child: Text('Grab', style: TextStyle(fontSize: 18),),
                          onPressed: () async {
                            await this.grab(widget.driverId,id);
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
