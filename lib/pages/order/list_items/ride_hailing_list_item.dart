import 'package:driver/common/model/order/order_detail.dart';
import 'package:driver/common/model/order/order_other.dart';
import 'package:driver/common/style/custom_theme.dart';
import 'package:driver/common/style/trip_on_icons.dart';
import 'package:driver/widgets/start_arrive_widget.dart';
import 'package:driver/widgets/to_card.dart';
import 'package:flutter/material.dart';

class RideHailingListItem extends StatelessWidget {
  RideHailingListItem(this.info, {Key key, this.actionBuilder})
      : super(key: key);

  final OrderInfoModel info;
  final WidgetBuilder actionBuilder;

  final _bodyFontColor = Color(0xFFA2A0A0);

  @override
  Widget build(BuildContext context) {
    final other = info.other as Other7;
    final transformType = 'Ride-hailing';
    return TOCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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

          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  top: 6,
                  bottom: 6,
                  right: 10,
                ),
                child: Icon(
                  TripOnIcons.shijian,
                  color: _bodyFontColor,
                  size: 20,
                ),
              ),
              Text(
                other.startTime,
                style: TextStyle(color: _bodyFontColor, fontSize: 12),
              ),
            ],
          ),

          StartArriveWidget(
            title: Tooltip(
              message: other.startAddress,
              child: Text(
                other.startAddress,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          StartArriveWidget(
            title: Tooltip(
              message: other.endAddress,
              child: Text(
                other.endAddress,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            isStart: false,
          ),

          SizedBox(height: 20),
          // sum
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text.rich(
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
              if (actionBuilder != null) actionBuilder(context),
            ],
          ),
        ],
      ),
    );
  }
}
