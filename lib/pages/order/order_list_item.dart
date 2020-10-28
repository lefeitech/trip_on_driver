import 'package:driver/common/enums/order.dart';
import 'package:driver/common/model/order/order_detail.dart';
import 'package:driver/common/style/custom_theme.dart';
import 'package:driver/common/style/trip_on_icons.dart';
import 'package:driver/common/utils/order.dart';
import 'package:driver/widgets/start_arrive_widget.dart';
import 'package:driver/widgets/to_card.dart';
import 'package:flutter/material.dart';

class OrderListItem extends StatelessWidget {
  OrderListItem(this.info, {Key key, this.onTap}) : super(key: key);

  final OrderInfoModel info;
  final VoidCallback onTap;
  final _bodyFontColor = Color(0xFFA2A0A0);

  @override
  Widget build(BuildContext context) {
    final transformType = 'Ride-hailing';
    // final transformType = OrderUtil.mapTransformType(info.other.type);
    return GestureDetector(
      onTap: onTap ?? () {},
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
                      Text(info.createTime ?? '', style: TextStyle(color: _bodyFontColor, fontSize: 12)),
                      const SizedBox(height: 2),
                      Text('No.${info.outTradeNo}', style: TextStyle(color: _bodyFontColor, fontSize: 10)),
                    ],
                  ),
                )
              ],
            ),
            if (info.other?.flight != null)
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 6, bottom: 6, right: 10),
                    child: Icon(TripOnIcons.shijian, color: _bodyFontColor, size: 20),
                  ),
                  Text(' ${info.other.flight}', style: TextStyle(color: _bodyFontColor, fontSize: 12)),
                ],
              ),
            // start point and arrive point
            if (info.other.type == TransformType.pickUp) ...[
              StartArriveWidget(title: Text(info.other.airport)),
              StartArriveWidget(title: Text(info.other.destination), isStart: false),
            ] else ...[
              StartArriveWidget(title: Text(info.other.destination)),
              StartArriveWidget(title: Text(info.other.airport), isStart: false),
            ],

            SizedBox(height: 20),
            // sum
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text.rich(
                TextSpan(
                  text: 'lump sum：RM',
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
          ],
        ),
      ),
    );
  }
}
