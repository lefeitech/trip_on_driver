import 'package:driver/common/model/common.dart' show asT;
import 'dart:convert' show json;

class ImageRes {
  ImageRes({
    this.code,
    this.msg,
    this.data,
  });

  factory ImageRes.fromJson(Map<String, dynamic> jsonRes) => jsonRes == null
      ? null
      : ImageRes(
          code: asT<int>(jsonRes['code']),
          msg: asT<String>(jsonRes['msg']),
          data: Data.fromJson(asT<Map<String, dynamic>>(jsonRes['data'])),
        );

  int code;
  String msg;
  Data data;

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

class Data {
  Data({
    this.url,
    this.baseUrl,
  });

  factory Data.fromJson(Map<String, dynamic> jsonRes) => jsonRes == null
      ? null
      : Data(
          url: asT<String>(jsonRes['url']),
          baseUrl: asT<String>(jsonRes['base_url']),
        );

  String url;
  String baseUrl;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'url': url,
        'base_url': baseUrl,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
