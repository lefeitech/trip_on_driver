import '../config/config.dart';

class BaseUrl {
  static String host = Config.host;

  static String userRegister = '$host/${Config.HTTP_VERSION}/user_register';
  static String userLogin = '$host/${Config.HTTP_VERSION}/user_login';
  static String userInfo = '$host/${Config.HTTP_VERSION}/user_info';
}
