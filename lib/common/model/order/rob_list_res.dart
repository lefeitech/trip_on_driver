import 'dart:convert' show json;

T asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }

  return null;
}

class RobListRes {
  RobListRes({
    this.code,
    this.msg,
    this.data,
  });

  factory RobListRes.fromJson(Map<String, dynamic> jsonRes) => jsonRes == null
      ? null
      : RobListRes(
          code: asT<int>(jsonRes['code']),
          msg: asT<String>(jsonRes['msg']),
          data:
              RobListData.fromJson(asT<Map<String, dynamic>>(jsonRes['data'])),
        );

  int code;
  String msg;
  RobListData data;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'code': code,
        'msg': msg,
        'data': data,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class RobListData {
  RobListData({
    this.count,
    this.info,
    this.finish,
  });

  factory RobListData.fromJson(Map<String, dynamic> jsonRes) {
    if (jsonRes == null) {
      return null;
    }

    final List<RobInfo> info = jsonRes['info'] is List ? <RobInfo>[] : null;
    if (info != null) {
      for (final dynamic item in jsonRes['info']) {
        if (item != null) {
          info.add(RobInfo.fromJson(asT<Map<String, dynamic>>(item)));
        }
      }
    }
    return RobListData(
      count: asT<int>(jsonRes['count']),
      info: info,
      finish: asT<int>(jsonRes['finish']),
    );
  }

  int count;
  List<RobInfo> info;
  int finish;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'count': count,
        'info': info,
        'finish': finish,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class RobInfo {
  RobInfo({
    this.id,
    this.customerId,
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
    // this.confirmTime,
    // this.finishTime,
    // this.refundTime,
    // this.cancelTime,
    this.carTypeId,
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
    this.carhailingId,
    this.other,
  });

  factory RobInfo.fromJson(Map<String, dynamic> jsonRes) => jsonRes == null
      ? null
      : RobInfo(
          id: asT<int>(jsonRes['id']),
          customerId: asT<int>(jsonRes['customer_id']),
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
          updateTime: asT<String>(jsonRes['update_time']),
          oncarTime: asT<String>(jsonRes['oncar_time']),
          payTime: asT<String>(jsonRes['pay_time']),
          // confirmTime: asT<String>(jsonRes['confirm_time']),
          // finishTime: asT<String>(jsonRes['finish_time']),
          // refundTime: asT<String>(jsonRes['refund_time']),
          // cancelTime: asT<String>(jsonRes['cancel_time']),
          carTypeId: asT<int>(jsonRes['car_type_id']),
          carId: asT<int>(jsonRes['car_id']),
          carMoney: asT<int>(jsonRes['car_money']),
          couponId: asT<int>(jsonRes['coupon_id']),
          couponMoney: asT<int>(jsonRes['coupon_money']),
          serviceId: asT<int>(jsonRes['service_id']),
          serviceMoney: asT<double>(jsonRes['service_money']),
          payTotalMoney: asT<double>(jsonRes['pay_total_money']),
          remark: asT<String>(jsonRes['remark']),
          driverId: asT<int>(jsonRes['driver_id']),
          score: asT<int>(jsonRes['score']),
          orderTypeId: asT<int>(jsonRes['order_type_id']),
          destinationId: asT<int>(jsonRes['destination_id']),
          includeId: asT<int>(jsonRes['include_id']),
          planeId: asT<int>(jsonRes['plane_id']),
          rentId: asT<int>(jsonRes['rent_id']),
          carhailingId: asT<int>(jsonRes['carhailing_id']),
          other: Other.fromJson(asT<Map<String, dynamic>>(jsonRes['other'])),
        );

  int id;
  int customerId;
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
  String updateTime;
  String oncarTime;
  String payTime;
  // String confirmTime;
  // String finishTime;
  // String refundTime;
  // String cancelTime;
  int carTypeId;
  int carId;
  int carMoney;
  int couponId;
  int couponMoney;
  int serviceId;
  double serviceMoney;
  double payTotalMoney;
  String remark;
  int driverId;
  int score;
  int orderTypeId;
  int destinationId;
  int includeId;
  int planeId;
  int rentId;
  int carhailingId;
  Other other;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'customer_id': customerId,
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
        // 'confirm_time': confirmTime,
        // 'finish_time': finishTime,
        // 'refund_time': refundTime,
        // 'cancel_time': cancelTime,
        'car_type_id': carTypeId,
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
        'carhailing_id': carhailingId,
        'other': other,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Other {
  Other({
    this.id,
    this.startLongitude,
    this.startLatitude,
    this.startAddress,
    this.startTime,
    this.distance,
    this.expectTime,
    this.endLongitude,
    this.endLatitude,
    this.endAddress,
    this.isPerson,
  });

  factory Other.fromJson(Map<String, dynamic> jsonRes) => jsonRes == null
      ? null
      : Other(
          id: asT<int>(jsonRes['id']),
          startLongitude: asT<String>(jsonRes['start_longitude']),
          startLatitude: asT<String>(jsonRes['start_latitude']),
          startAddress: asT<String>(jsonRes['start_address']),
          startTime: asT<String>(jsonRes['start_time']),
          distance: asT<String>(jsonRes['distance']),
          expectTime: asT<String>(jsonRes['expect_time']),
          endLongitude: asT<String>(jsonRes['end_longitude']),
          endLatitude: asT<String>(jsonRes['end_latitude']),
          endAddress: asT<String>(jsonRes['end_address']),
          isPerson: asT<int>(jsonRes['is_person']),
        );

  int id;
  String startLongitude;
  String startLatitude;
  String startAddress;
  String startTime;
  String distance;
  String expectTime;
  String endLongitude;
  String endLatitude;
  String endAddress;
  int isPerson;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'start_longitude': startLongitude,
        'start_latitude': startLatitude,
        'start_address': startAddress,
        'start_time': startTime,
        'distance': distance,
        'expect_time': expectTime,
        'end_longitude': endLongitude,
        'end_latitude': endLatitude,
        'end_address': endAddress,
        'is_person': isPerson,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
