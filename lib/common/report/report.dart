import 'package:driver/common/config/config.dart';
import 'package:driver/common/utils/log.dart';
import 'package:sentry/sentry.dart';

final SentryClient _sentry = SentryClient(dsn: Config.SENTRY_DSN);

Future<Null> reportError(dynamic error, dynamic stackTrace) async {
  if (!Config.debugMode) {
    LogUtil.v('Caught error: $error');
    final SentryResponse response = await _sentry.captureException(
      exception: error,
      stackTrace: stackTrace,
    );

    if (response.isSuccessful) {
      LogUtil.v('Success! Event ID: ${response.eventId}');
    } else {
      LogUtil.v('Failed to report to Sentry.io: ${response.error}');
    }
  }
}
