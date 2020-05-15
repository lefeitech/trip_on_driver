import 'package:driver/common/config/config.dart';
import 'package:sentry/sentry.dart';

final SentryClient _sentry = SentryClient(dsn: Config.SENTRY_DSN);

Future<Null> reportError(dynamic error, dynamic stackTrace) async {
  if (!Config.debugMode) {
    print('Caught error: $error');
    final SentryResponse response = await _sentry.captureException(
      exception: error,
      stackTrace: stackTrace,
    );

    if (response.isSuccessful) {
      print('Success! Event ID: ${response.eventId}');
    } else {
      print('Failed to report to Sentry.io: ${response.error}');
    }
  }
}
