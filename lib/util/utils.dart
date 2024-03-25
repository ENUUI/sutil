import 'dart:async';

export '../extensions/date.dart';
export 'logger.dart';
export 'ragex.dart';
export 'retry.dart';
export 'rsa.dart';
export 'throttle.dart';
export 'uuid.dart';
export 'date_format.dart';

bool get debug {
  bool inDebugMode = false;
  assert(inDebugMode = true);
  return inDebugMode;
}

void nextTick(FutureOr<void> Function() onTick) {
  Future.delayed(Duration.zero, onTick);
}
