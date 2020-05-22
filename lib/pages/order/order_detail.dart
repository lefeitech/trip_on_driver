import 'package:driver/common/enums/order.dart';
import 'package:driver/common/model/order/order_detail.dart';
import 'package:driver/common/style/custom_theme.dart';
import 'package:driver/common/style/trip_on_icons.dart';
import 'package:driver/common/utils/order.dart';
import 'package:driver/widgets/start_arrive_widget.dart';
import 'package:driver/widgets/to_card.dart';
import 'package:flutter/material.dart';

/// 订单详情
class OrderDetailPage extends StatelessWidget {
  OrderDetailPage(this.order);

  final OrderInfoModel order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(title: Text("Order Detail")),
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
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: <Widget>[
            _PriceWidget(order),
            _TravelInfoWidget(order),
            _PassengerInfoDisplayWidget(order),
            _AdditionalWidget(order.serviceInfo),
          ],
        ),
      ),
    );
  }
}

class _PriceWidget extends StatelessWidget {
  _PriceWidget(this.order);

  final OrderInfoModel order;

  @override
  Widget build(BuildContext context) {
    return TOCard(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          children: <Widget>[
            DefaultTextStyle(
              style: TextStyle(color: Colors.black38),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    OrderUtil.mapOrderStatus(order.state),
                    style: Theme.of(context).textTheme.subtitle1.copyWith(fontSize: 18),
                  ),
                  if (order.payTotalMoney != null)
                    RichText(
                      text: TextSpan(
                        text: "¥ ",
                        style: TextStyle(color: Colors.black38, fontSize: 12.0),
                        children: [
                          TextSpan(
                            text: '${order.payTotalMoney ?? ''}',
                            style: TextStyle(
                              color: CustomTheme.of(context).tipAlertColor,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 16),
            DefaultTextStyle(
              style: Theme.of(context).textTheme.caption,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(order.createTime ?? ''),
                  Text('No.${order.outTradeNo}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TravelInfoWidget extends StatelessWidget {
  _TravelInfoWidget(this.order);

  final OrderInfoModel order;

  @override
  Widget build(BuildContext context) {
    return TOCard(
      padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 36),
      child: IconTheme(
        data: IconThemeData(color: Colors.black38, size: 20.0),
        child: DefaultTextStyle(
          style: TextStyle(
            color: Color(0xFF222222),
            fontSize: 12.0,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(TripOnIcons.hangcheng),
                  SizedBox(width: 10.0),
                  Text(order.carInfo?.carName ?? ''),
                ],
              ),
              SizedBox(height: 10.0),
//              Row(
//                crossAxisAlignment: CrossAxisAlignment.center,
//                children: <Widget>[
//                  Icon(Icons.check_box),
//                  SizedBox(width: 10.0),
//                  Expanded(child: Text("TOVOTA-丰田COASTER-15 seats")),
//                ],
//              ),
//              SizedBox(height: 10.0),
              // start point and arrive point
              if (order.other.type == TransformType.pickUp) ...[
                StartArriveWidget(
                  title: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(order.other.airport),
                  ),
                  preferredWidth: 10,
                ),
                StartArriveWidget(
                  title: Padding(padding: const EdgeInsets.only(left: 20), child: Text(order.other.destination)),
                  isStart: false,
                  preferredWidth: 10,
                ),
              ] else ...[
                StartArriveWidget(
                  title: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(order.other.destination),
                  ),
                  preferredWidth: 10,
                ),
                StartArriveWidget(
                  title: Padding(padding: const EdgeInsets.only(left: 20), child: Text(order.other.airport)),
                  isStart: false,
                  preferredWidth: 10,
                ),
              ],
              SizedBox(height: 10.0),
              if (order.other?.distance != null)
                Row(
                  children: <Widget>[
                    Icon(TripOnIcons.juli),
                    SizedBox(width: 10.0),
                    Expanded(child: Text('${order.other.distance} km')),
                  ],
                ),
              SizedBox(height: 10.0),
              Row(
                children: <Widget>[
                  Icon(TripOnIcons.feiji),
                  SizedBox(width: 10.0),
                  Expanded(child: Text(order.other?.flight ?? '')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PassengerInfoDisplayWidget extends StatelessWidget with _FormLineMixin {
  _PassengerInfoDisplayWidget(this.order);

  final OrderInfoModel order;

  @override
  Widget build(BuildContext context) {
    return TOCard(
      padding: const EdgeInsets.only(top: 20, left: 36, right: 20, bottom: 26),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Passenger information", style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18)),
          SizedBox(height: 16),
          Column(
            children: <Widget>[
              _buildFormLine('passenger', order.rideName),
              _divider,
              _buildFormLine('phone', order.rideTel),
              _divider,
              _buildFormLine('requirements', order.remark ?? ''),
            ],
          ),
        ],
      ),
    );
  }
}

class _AdditionalWidget extends StatelessWidget with _FormLineMixin {
  _AdditionalWidget(this.info);

  final List<ServiceInfo> info;

  @override
  Widget build(BuildContext context) {
    return TOCard(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: IconTheme(
          data: IconThemeData(size: 18.0, color: Colors.black38),
          child: DefaultTextStyle(
            style: TextStyle(
              color: Color(0xFFD5D5D5),
              fontSize: 14.0,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Additional services", style: Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 18)),
                for (var i in info) ...[SizedBox(height: 10.0), _buildFormLine(i.serviceName, '\$${i.serviceMoney}')],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FormLineMixin {
  final _divider = Divider(height: 16);

  final _passengerStyle = TextStyle(
    color: Color(0xFFA2A0A0),
    fontSize: 14.0,
  );

  Widget _buildFormLine(String left, String right) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(child: Text(left, style: _passengerStyle), flex: 1),
        Expanded(child: Text(right, textAlign: TextAlign.end), flex: 2)
      ],
    );
  }
}

class _PassengerInfoEditWidget extends StatelessWidget {
  final _passengerStyle = TextStyle(
    color: Color(0xFFA2A0A0),
    fontSize: 14.0,
  );

  final _htiStyle = TextStyle(
    color: Color(0xFFAD5D5D5),
    fontSize: 14.0,
  );

  final _divider = Divider(height: 6);

  @override
  Widget build(BuildContext context) {
    return TOCard(
      padding: const EdgeInsets.only(top: 20, left: 36, right: 20, bottom: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("乘客信息", style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18)),
          SizedBox(height: 10.0),
          DefaultTextStyle(
            style: _passengerStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(child: Text("乘客", textAlign: TextAlign.start), flex: 1),
                    Expanded(
                      child: TextField(
                        style: _passengerStyle,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "请输入乘客姓名",
                          hintStyle: _htiStyle,
                        ),
                      ),
                      flex: 2,
                    )
                  ],
                ),
                _divider,
                Row(
                  children: <Widget>[
                    Expanded(child: Text("联系电话"), flex: 1),
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text("+86", style: TextStyle(color: Colors.black)),
                    ),
                    Expanded(
                      child: TextField(
                        style: _passengerStyle,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "请输入乘客电话",
                          hintStyle: _htiStyle,
                        ),
                      ),
                      flex: 2,
                    )
                  ],
                ),
                _divider,
                Row(
                  children: <Widget>[
                    Expanded(child: Text("邮箱"), flex: 1),
                    Expanded(
                      child: TextField(
                        style: _passengerStyle,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "请输入乘客邮箱",
                          hintStyle: _htiStyle,
                        ),
                      ),
                      flex: 2,
                    )
                  ],
                ),
                _divider,
                Row(
                  children: <Widget>[
                    Expanded(child: Text("特殊要求"), flex: 1),
                    Expanded(
                      child: TextField(
                        style: _passengerStyle,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "请输入特殊要求",
                          hintStyle: _htiStyle,
                        ),
                      ),
                      flex: 2,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
