import 'dart:io';
import 'package:dio/dio.dart' show Response, FormData, MultipartFile;
import 'package:driver/common/model/common.dart';
import 'package:driver/common/model/file/image.dart';
import 'package:driver/common/network/base_url.dart';
import 'package:driver/common/network/common_http.dart';

class FileApi {
  static CommonHttp http = CommonHttp();

  /// 上传单张图片
  static Future<ImageRes> uploadOneImage(File image) async {
    Map<String, dynamic> data = await CommonHttp.getExtraBody();
    final fileData = MultipartFile.fromFileSync(image.path);
    data.addAll({'file': fileData});
    FormData formData = FormData.fromMap(data);
    Response res = await http.post(BaseUrl.imageUploadOne, data: formData);
    return ImageRes.fromJson(res.data);
  }
}
