import 'package:intl/intl.dart';

class TimeUtil {
  static String formatTimeFromMill(int mill,
      [String format = 'yyyy-MM-dd HH:mm']) {
    DateFormat formatter = DateFormat(format);
    return formatter.format(DateTime.fromMillisecondsSinceEpoch(mill));
  }

  static String formatTimeFromDateTime(DateTime time,
      [String format = 'yyyy-MM-dd HH:mm']) {
    DateFormat formatter = DateFormat(format);
    return formatter.format(
        DateTime.fromMillisecondsSinceEpoch(time.millisecondsSinceEpoch));
  }
}
