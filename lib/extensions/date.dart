enum DatetimeType {
  year,
  month,
  day,
  hour,
  minute,
  second,
  millisecond,
  microsecond,
}

extension DateTimeExtra on DateTime {
  /// 比较两个时间, 默认比较到天; 更多比较类型请参考 [DatetimeType]
  /// -1 小于, 0 等于, 1 大于
  int compareWith(DateTime other, [DatetimeType type = DatetimeType.day]) {
    int result = year.compareTo(other.year);
    if (result != 0 || type == DatetimeType.year) {
      return result;
    }

    result = month.compareTo(other.month);
    if (result != 0 || type == DatetimeType.month) {
      return result;
    }

    result = day.compareTo(other.day);
    if (result != 0 || type == DatetimeType.day) {
      return result;
    }

    result = hour.compareTo(other.hour);
    if (result != 0 || type == DatetimeType.hour) {
      return result;
    }

    result = minute.compareTo(other.minute);
    if (result != 0 || type == DatetimeType.minute) {
      return result;
    }

    result = second.compareTo(other.second);
    if (result != 0 || type == DatetimeType.second) {
      return result;
    }

    result = millisecond.compareTo(other.millisecond);
    if (result != 0 || type == DatetimeType.millisecond) {
      return result;
    }

    return microsecond.compareTo(other.microsecond);
  }

  /// 是否相等, 默认比较到天; 更多比较类型请参考 [DatetimeType]
  bool equalTo(DateTime other, [DatetimeType type = DatetimeType.day]) {
    return compareWith(other, type) == 0;
  }

  /// 今天
  bool isToday() {
    final now = DateTime.now();
    return equalTo(now);
  }

  /// 昨天
  bool isYesterday() {
    final yesterday = DateTime.now().nextDay(-1);
    return equalTo(yesterday);
  }

  /// 前天
  bool isBeforeYesterday() {
    final beforeYesterday = DateTime.now().nextDay(-2);
    return equalTo(beforeYesterday);
  }

  /// 获取当月最大的DateTime in milliseconds
  DateTime get endOfMonth => DateTime(year, month + 1, 0, 23, 59, 59, 999, 999);

  /// 获取当月最小的DateTime
  DateTime get startOfMonth => DateTime.fromMillisecondsSinceEpoch(DateTime(year, month, 1).millisecondsSinceEpoch);

  /// 获取当天最小的DateTime
  DateTime get startOfDay => DateTime(year, month, day);

  /// 根据 DateTime 获取当天最大的时间戳
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999, 999);

  /// 获取下个月的最小时间
  DateTime nextMonth([int offset = 1]) {
    return DateTime(year, month + offset, 1);
  }

  /// 获取下一天的最小时间
  DateTime nextDay([int offset = 1]) {
    return DateTime(year, month, day + offset);
  }

  /// 计算两个时间相差的月份，没有考虑天数级别上的精确度
  int differenceInMonths(DateTime other) {
    return (other.year - year) * 12 + other.month - month;
  }

  /// 计算两个时间相差的天数, 自然日，不考虑时分秒
  int differenceInDays(DateTime other) {
    final thisDay = startOfDay;
    final otherDay = other.startOfDay;
    return thisDay.difference(otherDay).inDays;
  }
}
