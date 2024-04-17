import 'package:intl/intl.dart';
import '../extensions/date.dart';

const kSecondMilli = 1000;
const kMinutesMilli = 60 * kSecondMilli;
const kHourMilli = 60 * kMinutesMilli;
const kDayMilli = 24 * kHourMilli;

class Tick {
  static Tick now() => Tick(DateTime.now().millisecondsSinceEpoch);

  const Tick(this.milliseconds);

  /// Parse a date string to [Tick]
  /// [date] date string
  /// [f] format string, default is 'yyyy-MM-dd HH:mm'
  ///
  /// If the date string is invalid, throw a [FormatException]
  /// return [Tick]
  static Tick parse(String date, [String f = '']) {
    final DateTime dateTime;
    if (f.isEmpty) {
      dateTime = DateTime.parse(date);
    } else {
      dateTime = DateFormat(f).parse(date);
    }

    return dateTime.toTick();
  }

  static Tick? tryParse(String date, [String f = '']) {
    try {
      return parse(date, f);
    } catch (_) {
      // FormatException
      return null;
    }
  }

  final int milliseconds;

  DateTime get date => DateTime.fromMillisecondsSinceEpoch(milliseconds);

  String format([String f = 'yyyy-MM-dd HH:mm:ss', String? locale]) {
    return DateFormat(f, locale).format(date);
  }

  @override
  String toString() => 'Tick(milliseconds: $milliseconds, date: $date)';
}

/// DateTime extension
extension DateTimeTickExtra on DateTime {
  /// Convert [DateTime] to [Tick]
  Tick toTick() => Tick(millisecondsSinceEpoch);
}

/// 格式化时间
class Format {
  Format._();

  static int now() => DateTime.now().millisecondsSinceEpoch;

  static String nowTime([String f = 'yyyy年MM月']) => Format.f(now(), f);

  static String f(int milliseconds, [String f = 'yyyy年MM月dd日', String? locale]) {
    final date = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    return DateFormat(f, locale).format(date);
  }

  static String formatYear(int milliseconds, [String? locale]) {
    if (DateTime.now().year == DateTime.fromMillisecondsSinceEpoch(milliseconds).year) {
      return f(milliseconds, 'MM-dd HH:mm', locale);
    }
    return f(milliseconds, 'yyyy-MM-dd HH:mm', locale);
  }

  static int? p(String date, [String f = 'yyyy年MM月dd日', String? locale]) {
    try {
      return DateFormat(f, locale).parse(date).millisecondsSinceEpoch;
    } catch (_) {
      return null;
    }
  }

  static String formatTime(int timeNum) {
    return timeNum < 10 ? '0$timeNum' : timeNum.toString();
  }

  static String formatDuration(Duration position, {bool needHour = true}) {
    final milliseconds = position.inMilliseconds;
    int seconds = milliseconds ~/ 1000;
    final int hours = seconds ~/ 3600;
    if (needHour) {
      seconds = seconds % 3600;
    }
    var minutes = seconds ~/ 60;
    seconds = seconds % 60;

    final hoursString = formatTime(hours);

    final minutesString = formatTime(minutes);

    final secondsString = formatTime(seconds);

    final formattedTime = '${needHour ? hoursString == '00' ? '' : '$hoursString:' : ''}$minutesString:$secondsString';

    return formattedTime;
  }

  static String rf(
    int milliseconds, {
    String todayTime = 'HH:mm',
    String thisYearPattern = 'M月d日',
    String yearPattern = 'yyyy年M月d日',
    String? locale,
  }) {
    final date = DateTime.fromMillisecondsSinceEpoch(milliseconds);

    final now = DateTime.now();

    final diff = now.difference(date);

    if (diff <= const Duration(minutes: 1)) {
      return '刚刚';
    }

    if (diff < const Duration(hours: 1)) {
      return '${diff.inMilliseconds ~/ kMinutesMilli}分钟前';
    }

    if (diff < const Duration(hours: 4)) {
      return '${diff.inMilliseconds ~/ kHourMilli}小时前';
    }

    // 今天
    if (date.equalTo(now)) {
      return f(milliseconds, 'HH:mm', locale);
    }

    // 昨天
    if (date.isYesterday()) {
      return '昨天 ${f(milliseconds, todayTime, locale)}';
    }

    if (diff < const Duration(days: 7)) {
      return '${weekdayName(date.weekday)} ${f(milliseconds, 'HH:mm', locale)}';
    }

    if (date.year == now.year) {
      return f(milliseconds, thisYearPattern, locale);
    }

    return f(milliseconds, yearPattern, locale);
  }

  static String weekdayName(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return '周一';
      case DateTime.tuesday:
        return '周二';
      case DateTime.wednesday:
        return '周三';
      case DateTime.thursday:
        return '周四';
      case DateTime.friday:
        return '周五';
      case DateTime.saturday:
        return '周六';
      case DateTime.sunday:
        return '周日';
    }
    return "";
  }

  static String monthToLocal(int month) {
    if (month < 1 || month > 12) {
      assert(false, '');
      return '';
    }
    const List<String> chineseDigits = ['一', '二', '三', '四', '五', '六', '七', '八', '九', '十', '十一', '十二'];
    return '${chineseDigits[month - 1]}月';
  }
}
