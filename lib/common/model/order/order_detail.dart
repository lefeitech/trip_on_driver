import 'dart:convert';
import 'package:driver/common/enums/order.dart';
import 'package:driver/common/model/common.dart' show asT;
import 'package:driver/common/model/user/user_info.dart';
import 'order_other.dart';

class OrderInfoModel<T extends OtherBase> {
  OrderInfoModel({
    this.id,
    this.openid,
    this.adultNumber,
    this.childrenNumber,
    this.luggageNumber,
    this.rideName,
    this.rideTel,
    this.rideWechat,
    this.rideTel2,
    this.state,
    this.wxId,
    this.prepayId,
    this.outTradeNo,
    this.createTime,
    this.updateTime,
    this.oncarTime,
    this.payTime,
    this.confirmTime,
    this.finishTime,
    this.refundTime,
    this.cancelTime,
    this.carId,
    this.carMoney,
    this.couponId,
    this.couponMoney,
    this.serviceId,
    this.serviceMoney,
    this.payTotalMoney,
    this.remark,
    this.driverId,
    this.score,
    this.orderTypeId,
    this.destinationId,
    this.includeId,
    this.planeId,
    this.rentId,
    this.carInfo,
    this.serviceInfo,
    this.driverInfo,
    this.other,
  });

  factory OrderInfoModel.fromJson(Map<String, dynamic> jsonRes) {
    if (jsonRes == null) {
      return null;
    }

    final List<ServiceInfo> serviceInfo =
        jsonRes['service_info'] is List ? <ServiceInfo>[] : null;
    if (serviceInfo != null) {
      for (final dynamic item in jsonRes['service_info']) {
        if (item != null) {
          serviceInfo
              .add(ServiceInfo.fromJson(asT<Map<String, dynamic>>(item)));
        }
      }
    }

    final _typeId = asT<int>(jsonRes['order_type_id']);
    final _otherMap = asT<Map<String, dynamic>>(jsonRes['other']);
    OtherBase _other;

    switch (_typeId) {
      case OrderType.airport:
        _other = Other1.fromJson(_otherMap);
        break;
      case OrderType.charter:
        _other = Other2.fromJson(_otherMap);
        break;
      case OrderType.rideHailing:
        _other = Other7.fromJson(_otherMap);
        break;
      default:
        break;
    }

    return OrderInfoModel(
      id: asT<int>(jsonRes['id']),
      openid: asT<String>(jsonRes['openid']),
      adultNumber: asT<int>(jsonRes['adult_number']),
      childrenNumber: asT<int>(jsonRes['children_number']),
      luggageNumber: asT<int>(jsonRes['luggage_number']),
      rideName: asT<String>(jsonRes['ride_name']),
      rideTel: asT<String>(jsonRes['ride_tel']),
      rideWechat: asT<String>(jsonRes['ride_wechat']),
      rideTel2: asT<String>(jsonRes['ride_tel2']),
      state: asT<int>(jsonRes['state']),
      wxId: asT<String>(jsonRes['wx_id']),
      prepayId: asT<String>(jsonRes['prepay_id']),
      outTradeNo: asT<String>(jsonRes['out_trade_no']),
      createTime: asT<String>(jsonRes['create_time']),
      updateTime: asT<int>(jsonRes['update_time']),
      oncarTime: asT<int>(jsonRes['oncar_time']),
      payTime: asT<int>(jsonRes['pay_time']),
      confirmTime: asT<String>(jsonRes['confirm_time']),
      finishTime: asT<int>(jsonRes['finish_time']),
      refundTime: asT<int>(jsonRes['refund_time']),
      cancelTime: asT<int>(jsonRes['cancel_time']),
      carId: asT<int>(jsonRes['car_id']),
      carMoney: asT<int>(jsonRes['car_money']),
      couponId: asT<int>(jsonRes['coupon_id']),
      couponMoney: asT<int>(jsonRes['coupon_money']),
      serviceId: asT<String>(jsonRes['service_id']),
      serviceMoney: asT<int>(jsonRes['service_money']),
      payTotalMoney: asT<double>(jsonRes['pay_total_money']),
      remark: asT<String>(jsonRes['remark']),
      driverId: asT<int>(jsonRes['driver_id']),
      score: asT<int>(jsonRes['score']),
      orderTypeId: asT<int>(jsonRes['order_type_id']),
      destinationId: asT<int>(jsonRes['destination_id']),
      includeId: asT<int>(jsonRes['include_id']),
      planeId: asT<int>(jsonRes['plane_id']),
      rentId: asT<int>(jsonRes['rent_id']),
      carInfo:
          CarInfoModel.fromJson(asT<Map<String, dynamic>>(jsonRes['car_info'])),
      serviceInfo: serviceInfo,
      driverInfo: UserInfoModel.fromJson(
          asT<Map<String, dynamic>>(jsonRes['driver_info'])),
      other: _other,
    );
  }

  int id;
  String openid;
  int adultNumber;
  int childrenNumber;
  int luggageNumber;
  String rideName;
  String rideTel;
  String rideWechat;
  String rideTel2;
  int state;
  String wxId;
  String prepayId;
  String outTradeNo;
  String createTime;
  int updateTime;
  int oncarTime;
  int payTime;
  String confirmTime;
  int finishTime;
  int refundTime;
  int cancelTime;
  int carId;
  int carMoney;
  int couponId;
  int couponMoney;
  String serviceId;
  int serviceMoney;
  double payTotalMoney;
  String remark;
  int driverId;
  int score;
  int orderTypeId;
  int destinationId;
  int includeId;
  int planeId;
  int rentId;
  CarInfoModel carInfo;
  List<ServiceInfo> serviceInfo;
  UserInfoModel driverInfo;
  T other;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'openid': openid,
        'adult_number': adultNumber,
        'children_number': childrenNumber,
        'luggage_number': luggageNumber,
        'ride_name': rideName,
        'ride_tel': rideTel,
        'ride_wechat': rideWechat,
        'ride_tel2': rideTel2,
        'state': state,
        'wx_id': wxId,
        'prepay_id': prepayId,
        'out_trade_no': outTradeNo,
        'create_time': createTime,
        'update_time': updateTime,
        'oncar_time': oncarTime,
        'pay_time': payTime,
        'confirm_time': confirmTime,
        'finish_time': finishTime,
        'refund_time': refundTime,
        'cancel_time': cancelTime,
        'car_id': carId,
        'car_money': carMoney,
        'coupon_id': couponId,
        'coupon_money': couponMoney,
        'service_id': serviceId,
        'service_money': serviceMoney,
        'pay_total_money': payTotalMoney,
        'remark': remark,
        'driver_id': driverId,
        'score': score,
        'order_type_id': orderTypeId,
        'destination_id': destinationId,
        'include_id': includeId,
        'plane_id': planeId,
        'rent_id': rentId,
        'car_info': carInfo,
        'service_info': serviceInfo,
        'driver_info': driverInfo,
        'other': other,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class CarInfoModel {
  CarInfoModel({
    this.carIcon,
    this.carName,
    this.carPeople,
    this.carLuggage,
    this.carRemark,
  });

  factory CarInfoModel.fromJson(Map<String, dynamic> jsonRes) => jsonRes == null
      ? null
      : CarInfoModel(
          carIcon: asT<String>(jsonRes['car_icon']),
          carName: asT<String>(jsonRes['car_name']),
          carPeople: asT<int>(jsonRes['car_people']),
          carLuggage: asT<int>(jsonRes['car_luggage']),
          carRemark: asT<String>(jsonRes['car_remark']),
        );

  String carIcon;
  String carName;
  int carPeople;
  int carLuggage;
  String carRemark;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'car_icon': carIcon,
        'car_name': carName,
        'car_people': carPeople,
        'car_luggage': carLuggage,
        'car_remark': carRemark,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class ServiceInfo {
  ServiceInfo({
    this.serviceName,
    this.serviceMoney,
    this.serviceIcon,
    this.serviceContent,
    this.serviceType,
  });

  factory ServiceInfo.fromJson(Map<String, dynamic> jsonRes) => jsonRes == null
      ? null
      : ServiceInfo(
          serviceName: asT<String>(jsonRes['service_name']),
          serviceMoney: asT<int>(jsonRes['service_money']),
          serviceIcon: asT<String>(jsonRes['service_icon']),
          serviceContent: asT<String>(jsonRes['service_content']),
          serviceType: asT<int>(jsonRes['service_type']),
        );

  String serviceName;
  int serviceMoney;
  String serviceIcon;
  String serviceContent;
  int serviceType;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'service_name': serviceName,
        'service_money': serviceMoney,
        'service_icon': serviceIcon,
        'service_content': serviceContent,
        'service_type': serviceType,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
