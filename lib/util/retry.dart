import 'dart:async';

Future<void> attempt(
  FutureOr<void> Function() callback, {
  int maxAttempts = 3,
  Duration delay = const Duration(seconds: 1),
  bool Function(Object)? retryIf,
}) async {
  var attempts = 0;
  while (true) {
    try {
      await callback();
      break;
    } catch (e) {
      attempts++;
      if (attempts >= maxAttempts) {
        rethrow;
      }
      if (retryIf != null && !retryIf(e)) {
        rethrow;
      }
      await Future.delayed(delay);
    }
  }
}
