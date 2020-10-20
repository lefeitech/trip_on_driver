import 'package:driver/common/enums/order.dart';
import 'package:driver/common/model/order/rob_list_res.dart';
import 'package:driver/common/style/custom_theme.dart';
import 'package:driver/common/style/trip_on_icons.dart';
import 'package:driver/common/utils/order.dart';
import 'package:driver/widgets/start_arrive_widget.dart';
import 'package:driver/widgets/to_card.dart';
import 'package:flutter/material.dart';

class RobListItem extends StatelessWidget {
  RobListItem(this.info);
  final RobInfo info;

  final _bodyFontColor = Color(0xFFA2A0A0);
  @override
  Widget build(BuildContext context) {
    final transformType = 'Ride-hailing';
    // final transformType = OrderUtil.mapTransformType(info.other.type);
    return GestureDetector(
      onTap: () {
        // todo detail page
      },
      child:  TOCard(
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
                      Text('No.${info.outTradeNo ?? ''}', style: TextStyle(color: _bodyFontColor, fontSize: 10)),
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
                Text(info.other.startTime, style: TextStyle(color: _bodyFontColor, fontSize: 12)),
              ],
            ),
            // start point and arrive point
            StartArriveWidget(title: Text(info.other.startAddress)),
            StartArriveWidget(title: Text(info.other.endAddress), isStart: false),
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
                          text: '${info.payTotalMoney?.toString() ?? ''}',
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
                            color: Color(0xFF4FAFF8),
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
                      // await this.grab(widget.driverId,id);
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
}
