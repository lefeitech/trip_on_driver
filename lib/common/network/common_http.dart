import 'package:dio/dio.dart';
import 'package:driver/common/config/config.dart';
import 'dart:async';

import 'interceptor.dart';

class CommonHttp {
  static const CONTENT_TYPE_JSON = "application/json";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";

  CommonHttp._internal() {
    _initInterceptor(_dio);
    _addProxy(_dio);
  }

  static CommonHttp _singleton = CommonHttp._internal();

  factory CommonHttp() => _singleton;

  static Dio _dio = Dio();

  Options _mergeOptions(Options options, Map<String, dynamic> config) {
    Options _options;
    if (options == null) {
      _options = Options(extra: config);
    } else {
      options.merge(extra: config);
      _options = options;
    }
    return _options;
  }

  Future<Response<T>> get<T>(
      String path, {
        Map<String, dynamic> queryParameters,
        Options options,
        CancelToken cancelToken,
        ProgressCallback onReceiveProgress,
        bool showTip = false,
      }) async {
    Map<String, dynamic> config = {'showTip': showTip};
    return _dio.get<T>(path,
        queryParameters: queryParameters,
        options: _mergeOptions(options, config),
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress);
  }

  Future<Response<T>> post<T>(
      String path, {
        data,
        Map<String, dynamic> queryParameters,
        Options options,
        CancelToken cancelToken,
        ProgressCallback onSendProgress,
        ProgressCallback onReceiveProgress,
        bool showTip = false,
      }) {
    Map<String, dynamic> config = {'showTip': showTip};
    return _dio.post<T>(
      path,
      data: data,
      options: _mergeOptions(options, config),
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response<T>> put<T>(
      String path, {
        data,
        Map<String, dynamic> queryParameters,
        Options options,
        CancelToken cancelToken,
        ProgressCallback onSendProgress,
        ProgressCallback onReceiveProgress,
        bool showTip = false,
      }) {
    Map<String, dynamic> config = {'showTip': showTip};
    return _dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: _mergeOptions(options, config),
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response<T>> delete<T>(
      String path, {
        data,
        Map<String, dynamic> queryParameters,
        Options options,
        CancelToken cancelToken,
        bool showTip = false,
      }) {
    Map<String, dynamic> config = {'showTip': showTip};
    return _dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: _mergeOptions(options, config),
      cancelToken: cancelToken,
    );
  }

  void _initInterceptor(Dio dio) {
    if (Config.debugMode) {
      dio.interceptors.add(LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
      ));
    }
    dio.interceptors.add(ZGSInterceptor(dio));
  }

  void _addProxy(Dio dio) {
    /// 尴尬，我的postman开代理会崩
//    if (Config.DEBUG) {
//      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
//        client.findProxy = (uri) {
//          return "PROXY localhost:1011";
//        };
//      };
//    }
  }
}
