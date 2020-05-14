import '../config/config.dart';

class BaseUrl {
  static String host = Config.host;

  static String userRegister = '$host/${Config.HTTP_VERSION}/user_register';
  static String userLogin = '$host/${Config.HTTP_VERSION}/user_login';
  static String userInfo = '$host/${Config.HTTP_VERSION}/user_info';
  static String sendCode = '$host/${Config.HTTP_VERSION}/msg_send_code';
  static String imageUploadOne = '$host/${Config.HTTP_VERSION}/image_upload_one';
}
