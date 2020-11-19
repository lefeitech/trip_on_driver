import '../config/config.dart';

class BaseUrl {
  static String host = Config.host;

  static String userRegister = '$host/${Config.HTTP_VERSION}/user_register';
  static String userLogin = '$host/${Config.HTTP_VERSION}/user_login';
  static String userInfo = '$host/${Config.HTTP_VERSION}/user_info';
  static String sendCode = '$host/${Config.HTTP_VERSION}/msg_send_code';
  static String imageUploadOne =
      '$host/${Config.HTTP_VERSION}/image_upload_one';
  static String orderList = '$host/${Config.HTTP_VERSION}/order_list';
  static String orderDetail = '$host/${Config.HTTP_VERSION}/order_detail';
  static String robList = '$host/${Config.HTTP_VERSION}/rob_list';
  static String robState = '$host/${Config.HTTP_VERSION}/rob_state';
  static String orderState = '$host/${Config.HTTP_VERSION}/order_state';
}
