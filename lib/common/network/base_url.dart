import '../config/config.dart';

class BaseUrl {
  static String host = Config.host;

  static String auth = '$host/v2_api/auth';
}
