import 'package:driver/common/model/order/rob_list_res.dart';
import 'package:driver/common/style/custom_theme.dart';
import 'package:driver/common/style/trip_on_icons.dart';
import 'package:driver/common/utils/order.dart';
import 'package:driver/widgets/main_container.dart';
import 'package:driver/widgets/start_arrive_widget.dart';
import 'package:driver/widgets/to_card.dart';
import 'package:flutter/material.dart';

/// 抢单详情
class RobDetaolPage extends StatelessWidget {
  RobDetaolPage(this.info);

  final RobInfo info;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
        centerTitle: true,
      ),
      body: MainContainer(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: <Widget>[
            _PriceWidget(info),
            _TravelInfoWidget(info),
            _PassengerInfoDisplayWidget(info),
          ],
        ),
      ),
    );
  }
}

class _PriceWidget extends StatelessWidget {
  _PriceWidget(this.info);

  final RobInfo info;

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
                    OrderUtil.mapOrderStatus(info.state),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(fontSize: 18),
                  ),
                  if (info.payTotalMoney != null)
                    RichText(
                      text: TextSpan(
                        text: "RM ",
                        style: TextStyle(color: Colors.black38, fontSize: 12.0),
                        children: [
                          TextSpan(
                            text: '${info.payTotalMoney ?? ''}',
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
                  Text(info.createTime ?? ''),
                  Text('No.${info.outTradeNo}'),
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
  _TravelInfoWidget(this.info);

  final RobInfo info;
  final _bodyFontColor = Color(0xFFA2A0A0);

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
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 0,
                      bottom: 6,
                      right: 10,
                    ),
                    child: Icon(
                      TripOnIcons.shijian,
                      color: _bodyFontColor,
                      size: 20,
                    ),
                  ),
                  Text(info.other.startTime),
                ],
              ),
              // start point and arrive point
              StartArriveWidget(
                title: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    info.other.startAddress,
                    maxLines: 3,
                  ),
                ),
                preferredWidth: 18,
              ),
              StartArriveWidget(
                title: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    info.other.endAddress,
                    maxLines: 3,
                  ),
                ),
                isStart: false,
                preferredWidth: 18,
              ),
              SizedBox(height: 10.0),
              if (info.other?.distance != null)
                Row(
                  children: <Widget>[
                    Icon(TripOnIcons.juli),
                    SizedBox(width: 10.0),
                    Expanded(child: Text('${info.other.distance} km')),
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
  _PassengerInfoDisplayWidget(this.info);

  final RobInfo info;

  @override
  Widget build(BuildContext context) {
    return TOCard(
      padding: const EdgeInsets.only(top: 20, left: 36, right: 20, bottom: 26),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Passenger information",
            style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18),
          ),
          SizedBox(height: 16),
          Column(
            children: <Widget>[
              _buildFormLine('passenger', info.rideName ?? '--'),
              _divider,
              _buildFormLine('phone', info.rideTel ?? '--'),
              _divider,
              _buildFormLine('requirements', info.remark ?? '--'),
            ],
          ),
        ],
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
