import 'dart:async';

bool _enable = true;

void Function() throttle<T>(Future<T> Function() func) {
  return () {
    if (_enable) {
      _enable = false;
      func().timeout(const Duration(seconds: 5)).whenComplete(() {
        _enable = true;
      });
    }
  };
}
