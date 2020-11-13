import 'package:driver/common/enums/order.dart';
import 'package:driver/common/model/order/order_detail.dart';
import 'package:driver/pages/order/list_items/airport_list_item.dart';
import 'package:driver/pages/order/list_items/ride_hailing_list_item.dart';
import 'package:driver/pages/order/travel_info/airport_travel_info.dart';
import 'package:driver/pages/order/travel_info/raide_hailing_travel_info.dart';
import 'package:flutter/material.dart';

class OrderUtil {
  /// map order transform status
  // !info : for internationalize
  static String mapTransformType(int type) {
    var typeStr = '';
    switch (type) {
      case TransformType.pickUp:
        typeStr = 'Pick up';
        break;
      default:
        typeStr = 'Drop up';
        break;
    }
    return typeStr;
  }

  /// map order status [OrderState]
  /// !info : for internationalize
  static String mapOrderStatus(int type) {
    var typeStr = 'unknown';
    switch (type) {
      case OrderState.canceled:
        typeStr = 'Canceled';
        break;
      case OrderState.pendingPay:
        typeStr = 'Paying';
        break;
      case OrderState.paied:
        typeStr = 'Paied';
        break;
      case OrderState.picked:
        typeStr = 'Picked';
        break;
      case OrderState.passengerOnBoard:
        typeStr = 'Confirmed';
        break;
      case OrderState.done:
        typeStr = 'Done';
        break;
      default:
        break;
    }
    return typeStr;
  }

  static Widget mapListItemByType(
    OrderInfoModel info, {
    WidgetBuilder actionBuilder,
  }) {
    var item;
    switch (info.orderTypeId) {
      case OrderType.airport:
        item = AirportListItem(info, actionBuilder: actionBuilder);
        break;
      case OrderType.rideHailing:
        item = RideHailingListItem(info, actionBuilder: actionBuilder);
        break;
      default:
        break;
    }
    return item;
  }


  static Widget mapTravelWidgetByType(
      OrderInfoModel info) {
    var item;
    switch (info.orderTypeId) {
      case OrderType.airport:
        item = AirportTravelInfoWidget(info);
        break;
      case OrderType.rideHailing:
        item = RideHailingTravelInfoWidget(info);
        break;
      default:
        break;
    }
    return item;
  }
}
