import 'package:driver/common/enums/order.dart';
import 'package:driver/common/model/order/order_detail.dart';
import 'package:driver/common/model/order/order_other.dart';
import 'package:driver/common/style/custom_theme.dart';
import 'package:driver/common/style/trip_on_icons.dart';
import 'package:driver/common/utils/order.dart';
import 'package:driver/widgets/start_arrive_widget.dart';
import 'package:driver/widgets/to_card.dart';
import 'package:flutter/material.dart';

class AirportListItem extends StatelessWidget {
  AirportListItem(this.info, {Key key, this.actionBuilder}) : super(key: key);

  final OrderInfoModel info;
  final WidgetBuilder actionBuilder;

  final _bodyFontColor = Color(0xFFA2A0A0);

  @override
  Widget build(BuildContext context) {
    final other = info.other as Other1;
    final transformType = OrderUtil.mapTransformType(other.type);
    return TOCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // order title / time / no.
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                transformType,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(fontSize: 16),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    const SizedBox(height: 10),
                    Text(
                      info.createTime ?? '',
                      style: TextStyle(color: _bodyFontColor, fontSize: 12),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'No.${info.outTradeNo}',
                      style: TextStyle(color: _bodyFontColor, fontSize: 10),
                    ),
                  ],
                ),
              )
            ],
          ),
          if (other?.flight != null)
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    top: 6,
                    bottom: 6,
                    right: 10,
                  ),
                  child: Icon(TripOnIcons.shijian,
                      color: _bodyFontColor, size: 20),
                ),
                Text(
                  ' ${other.flight}',
                  style: TextStyle(color: _bodyFontColor, fontSize: 12),
                ),
              ],
            ),
          // start point and arrive point
          if (other.type == TransformType.pickUp) ...[
            StartArriveWidget(title: Text(other.airport)),
            StartArriveWidget(title: Text(other.destination), isStart: false),
          ] else ...[
            StartArriveWidget(title: Text(other.destination ?? '')),
            StartArriveWidget(title: Text(other.airport), isStart: false),
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
                    text: 'RM ',
                    style: TextStyle(color: _bodyFontColor, fontSize: 12),
                    children: [
                      TextSpan(
                        text: '${info.payTotalMoney ?? ''}',
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
              if (actionBuilder != null) actionBuilder(context),
            ],
          ),
        ],
      ),
    );
  }
}
