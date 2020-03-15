///错误编码
class Code {
  static const int DEFAULT_ERROR = 0;
  static const int NETWORK_ERROR = -1;
  static const int CONNECT_TIMEOUT = -2;
  static const int SEND_TIMEOUT = -3;
  static const int RECEIVE_TIMEOUT = -4;
  static const int CANCEL = -5;
  static const int SUCCESS = 200;
  static const int NOT_FOUND = 404;
  static const int NO_AUTH_401 = 401;
  static const int NO_AUTH_403 = 403;
  static const int SEVER_ERROR = 503;
  static const int GW_TIMEOUT = 504;
  static const int UNKNOWN = -100;
}
