import 'dart:convert' show json;
import 'package:driver/common/model/common.dart' show asT;

class UserInfoModel {
  UserInfoModel({
    this.id,
    this.driverTel,
    this.openid,
    this.score,
    this.driverName,
    this.driverNameEn,
    this.totalMoney,
    this.card1,
    this.card2,
    this.carNo,
    this.carColor,
    this.carMake,
    this.carSlide,
    this.state,
    this.remark,
    this.createTime,
    this.updateTime,
    this.loginTime,
    this.token,
    this.loginNumber,
    this.carNum,
    this.password,
    this.cardNo,
    this.emall,
    this.wechat,
    this.bankNo,
    this.tel2,
    this.code,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> jsonRes) {
    if (jsonRes == null) {
      return null;
    }

    final List<String> carSlide = jsonRes['car_slide'] is List ? <String>[] : null;
    if (carSlide != null) {
      for (final dynamic item in jsonRes['car_slide']) {
        if (item != null) {
          carSlide.add(asT<String>(item));
        }
      }
    }
    return UserInfoModel(
      id: asT<int>(jsonRes['id']),
      driverTel: asT<String>(jsonRes['driver_tel']),
      openid: asT<int>(jsonRes['openid']),
      score: asT<double>(jsonRes['score']),
      driverName: asT<String>(jsonRes['driver_name']),
      driverNameEn: asT<String>(jsonRes['driver_name_en']),
      totalMoney: asT<int>(jsonRes['total_money']),
      card1: asT<String>(jsonRes['card_1']),
      card2: asT<String>(jsonRes['card_2']),
      carNo: asT<String>(jsonRes['car_no']),
      carColor: asT<String>(jsonRes['car_color']),
      carMake: asT<String>(jsonRes['car_make']),
      carSlide: carSlide,
      state: asT<int>(jsonRes['state']),
      remark: asT<String>(jsonRes['remark']),
      createTime: asT<int>(jsonRes['create_time']),
      updateTime: asT<int>(jsonRes['update_time']),
      loginTime: asT<int>(jsonRes['login_time']),
      token: asT<String>(jsonRes['token']),
      loginNumber: asT<int>(jsonRes['login_number']),
      carNum: asT<int>(jsonRes['car_num']),
      password: asT<String>(jsonRes['password']),
      cardNo: asT<String>(jsonRes['card_no']),
      emall: asT<String>(jsonRes['emall']),
      wechat: asT<String>(jsonRes['wechat']),
      bankNo: asT<String>(jsonRes['bank_no']),
      tel2: asT<String>(jsonRes['tel2']),
      code: asT<int>(jsonRes['code']),
    );
  }

  int id;
  String driverTel;
  int openid;
  double score;
  String driverName;
  String driverNameEn;
  int totalMoney;
  String card1;
  String card2;
  String carNo;
  String carColor;
  String carMake;
  List<String> carSlide;
  int state;
  String remark;
  int createTime;
  int updateTime;
  int loginTime;
  String token;
  int loginNumber;
  int carNum;
  String password;
  String cardNo;
  String emall;
  String wechat;
  String bankNo;
  String tel2;
  int code;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'driver_tel': driverTel,
        'openid': openid,
        'score': score,
        'driver_name': driverName,
        'driver_name_en': driverNameEn,
        'total_money': totalMoney,
        'card_1': card1,
        'card_2': card2,
        'car_no': carNo,
        'car_color': carColor,
        'car_make': carMake,
        'car_slide': carSlide,
        'state': state,
        'remark': remark,
        'create_time': createTime,
        'update_time': updateTime,
        'login_time': loginTime,
        'token': token,
        'login_number': loginNumber,
        'car_num': carNum,
        'password': password,
        'card_no': cardNo,
        'emall': emall,
        'wechat': wechat,
        'bank_no': bankNo,
        'tel2': tel2,
        'code': code,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
