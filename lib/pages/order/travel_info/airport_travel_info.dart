import 'package:driver/common/enums/order.dart';
import 'package:driver/common/model/order/order_detail.dart';
import 'package:driver/common/model/order/order_other.dart';
import 'package:driver/common/style/trip_on_icons.dart';
import 'package:driver/widgets/start_arrive_widget.dart';
import 'package:driver/widgets/to_card.dart';
import 'package:flutter/material.dart';

class RideHailingTravelInfoWidget extends StatelessWidget {
  RideHailingTravelInfoWidget(this.order);

  final OrderInfoModel order;

  @override
  Widget build(BuildContext context) {
    final other = order.other as Other7;
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
              // start point and arrive point

              StartArriveWidget(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(other.startAddress),
                ),
                preferredWidth: 10,
              ),
              StartArriveWidget(
                title: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(other.endAddress),
                ),
                isStart: false,
                preferredWidth: 10,
              ),

              SizedBox(height: 10.0),
              if (other?.distance != null)
                Row(
                  children: <Widget>[
                    Icon(TripOnIcons.juli),
                    SizedBox(width: 10.0),
                    Expanded(child: Text('${other.distance} km')),
                  ],
                ),
              SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}
