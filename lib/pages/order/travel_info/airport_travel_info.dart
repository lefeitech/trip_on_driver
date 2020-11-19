import 'package:driver/common/enums/order.dart';
import 'package:driver/common/model/order/order_detail.dart';
import 'package:driver/common/model/order/order_other.dart';
import 'package:driver/common/style/trip_on_icons.dart';
import 'package:driver/widgets/start_arrive_widget.dart';
import 'package:driver/widgets/to_card.dart';
import 'package:flutter/material.dart';

class AirportTravelInfoWidget extends StatelessWidget {
  AirportTravelInfoWidget(this.order);

  final OrderInfoModel order;

  @override
  Widget build(BuildContext context) {
    final other = order.other as Other1;
    return TOCard(
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
                  Text(order.carInfo?.carName ?? '--'),
                ],
              ),
              SizedBox(height: 10.0),
              // start point and arrive point
              if (other.type == TransformType.pickUp) ...[
                StartArriveWidget(
                  title: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(other.airport),
                  ),
                  preferredWidth: 20,
                ),
                StartArriveWidget(
                  title: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(other.destination),
                  ),
                  isStart: false,
                  preferredWidth: 20,
                ),
              ] else ...[
                StartArriveWidget(
                  title: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(other.destination),
                  ),
                  preferredWidth: 20,
                ),
                StartArriveWidget(
                  title: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(other.airport),
                  ),
                  isStart: false,
                  preferredWidth: 20,
                ),
              ],
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
              Row(
                children: <Widget>[
                  Icon(TripOnIcons.feiji),
                  SizedBox(width: 10.0),
                  Expanded(child: Text(other?.flight ?? '')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
