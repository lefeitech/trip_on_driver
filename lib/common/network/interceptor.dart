import 'package:dio/dio.dart';
import 'package:driver/common/local/local_storage.dart';
import 'package:driver/common/network/code.dart';
import 'package:driver/common/network/common_http.dart';
import 'package:driver/common/report/report.dart';
import '../config/config.dart';

/// 拦截器
class ZGSInterceptor extends Interceptor {
  ZGSInterceptor(this.dio);

  final Dio dio;

  void sendHttpCode(int code) {
//    httpEventBloc.fireEvent(code);
  }

  @override
  onRequest(RequestOptions options) async {
    String token = await LocalStorage.get(Config.TOKEN_KEY);
    if (!options.path.contains('user_register')) {
      // except login
//      if (await CommonUtils.isNeedRefreshToken()) {
//        dio.lock();
//        String newToken = await refreshToken(token);
//        if (newToken != null) {
//          token = newToken;
//        }
//        // todo refresh error back to login
//        dio.unlock();
//      }
    }
    options.headers["AccessToken"] = '$token';

    final Map<String, dynamic> extraInfo = await CommonHttp.getExtraBody();
    if (options.data != null) {
      if (options.data is Map) {
        extraInfo.addAll(options.data);
        options.data = Map.from(extraInfo);
//          (options.data as Map<dynamic, Object>).addAll(extraInfo);
      }
    } else {
      options.data = extraInfo;
    }
    return options;
  }

  @override
  onResponse(Response response) async {
    if (response.data is Map<String, dynamic>) {}
    return response;
  }

  @override
  onError(DioError e) {
    bool showTip = e.request.extra['showTip'] ?? false;
    if (showTip == false) return Future.value(e);

    int code;
    switch (e.type) {
      case DioErrorType.DEFAULT:
        code = Code.DEFAULT_ERROR;
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        code = Code.CONNECT_TIMEOUT;
        break;
      case DioErrorType.SEND_TIMEOUT:
        code = Code.SEND_TIMEOUT;
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        code = Code.RECEIVE_TIMEOUT;
        break;
      case DioErrorType.RESPONSE:
        code = getErrorCode(e?.response?.statusCode);
        break;
      case DioErrorType.CANCEL:
        code = Code.CANCEL;
        break;
      default:
        code = Code.UNKNOWN;
    }

    if (showTip) {
      sendHttpCode(code);
    }

    reportError(e, null);

    return Future.value(e);
  }

  int getErrorCode(int statusCode) {
    int code;
    switch (statusCode) {
      case Code.NOT_FOUND:
        code = Code.NOT_FOUND;
        break;
      case Code.NO_AUTH_401:
        code = Code.NO_AUTH_401;
        break;
      case Code.NO_AUTH_403:
        code = Code.NO_AUTH_403;
        break;
      case Code.SEVER_ERROR:
        code = Code.SEVER_ERROR;
        break;
      case Code.GW_TIMEOUT:
        code = Code.GW_TIMEOUT;
        break;
      default:
        code = Code.UNKNOWN;
    }
    return code;
  }

  // Future<String> refreshToken(String token) async {
  //   String newToken;
  //   Dio dio = Dio();
  //   Response response;
  //
  //   return Future.value(newToken);
  // }
}
