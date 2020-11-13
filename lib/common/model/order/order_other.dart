import 'dart:convert';

import '../common.dart';

/// order type decoder
/// [Other1], [Other2], [Other7] all extends [OtherBase]
/// their name follow the code defined in [OderType]
/// limited type could use [as] keyword

abstract class OtherBase {
  OtherBase({this.id});

  int id;

  Map<String, dynamic> toJson();

  OtherBase.fromJson(Map<String, dynamic> jsonRes);
}

// 接送机
class Other1 implements OtherBase {
  Other1({
    this.id,
    this.type,
    this.airport,
    this.flight,
    this.flightTime,
    this.destination,
    this.distance,
    this.expectTime,
    this.createTime,
    this.updateTime,
    this.typeName,
  });

  factory Other1.fromJson(Map<String, dynamic> jsonRes) => jsonRes == null
      ? null
      : Other1(
          id: asT<int>(jsonRes['id']),
          type: asT<int>(jsonRes['type']),
          airport: asT<String>(jsonRes['airport']),
          flight: asT<String>(jsonRes['flight']),
          flightTime: asT<String>(jsonRes['flight_time']),
          destination: asT<String>(jsonRes['destination']),
          distance: asT<double>(jsonRes['distance']),
          expectTime: asT<int>(jsonRes['expect_time']),
          createTime: asT<int>(jsonRes['create_time']),
          updateTime: asT<int>(jsonRes['update_time']),
          typeName: asT<String>(jsonRes['type_name']),
        );

  int id;
  int type;
  String airport;
  String flight;
  String flightTime;
  String destination;
  double distance;
  int expectTime;
  int createTime;
  int updateTime;
  String typeName;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'type': type,
        'airport': airport,
        'flight': flight,
        'flight_time': flightTime,
        'destination': destination,
        'distance': distance,
        'expect_time': expectTime,
        'create_time': createTime,
        'update_time': updateTime,
        'type_name': typeName,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

// 包车游
class Other2 implements OtherBase {
  Other2({
    this.id,
    this.startCity,
    this.tourTime,
    this.mealId,
    this.mealContent,
    this.startAddress,
    this.startTime,
    this.endTime,
    this.createTime,
    this.updateTime,
  });

  factory Other2.fromJson(Map<String, dynamic> jsonRes) => jsonRes == null
      ? null
      : Other2(
          id: asT<int>(jsonRes['id']),
          startCity: asT<String>(jsonRes['start_city']),
          tourTime: asT<String>(jsonRes['tour_time']),
          mealId: asT<int>(jsonRes['meal_id']),
          mealContent: asT<String>(jsonRes['meal_content']),
          startAddress: asT<String>(jsonRes['start_address']),
          startTime: asT<int>(jsonRes['start_time']),
          endTime: asT<int>(jsonRes['end_time']),
          createTime: asT<int>(jsonRes['create_time']),
          updateTime: asT<Object>(jsonRes['update_time']),
        );

  int id;
  String startCity;
  String tourTime;
  int mealId;
  String mealContent;
  String startAddress;
  int startTime;
  int endTime;
  int createTime;
  Object updateTime;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'start_city': startCity,
        'tour_time': tourTime,
        'meal_id': mealId,
        'meal_content': mealContent,
        'start_address': startAddress,
        'start_time': startTime,
        'end_time': endTime,
        'create_time': createTime,
        'update_time': updateTime,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

// 网约车
class Other7 implements OtherBase {
  Other7({
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

  factory Other7.fromJson(Map<String, dynamic> jsonRes) => jsonRes == null
      ? null
      : Other7(
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
