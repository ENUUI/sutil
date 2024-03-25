import 'package:test/test.dart';
import 'package:sutil/sutil.dart' show DateTimeExtra, DatetimeType;

void main() {
  group('A group of tests', () {
    // 测试 DateTimeExtra 的方法
    test('DateTimeExtra endOfMonth', () {
      final dt = DateTime(2021, 1, 31, 23, 59, 59, 999, 999);
      final endDt = DateTime(2021, 1, 31, 23, 59, 59, 999, 999);
      expect(dt.endOfMonth, endDt);

      final dt2 = DateTime(2024, 2, 29);
      expect(dt2.endOfMonth, DateTime(2024, 2, 29, 23, 59, 59, 999, 999));
    });

    test('DateTimeExtra startOfMonth', () {
      final dt = DateTime(2021, 1, 31, 23, 59, 59, 999, 999);
      final startDt = DateTime(2021, 1, 1);
      expect(dt.startOfMonth, startDt);
    });

    test('DateTimeExtra startOfDay', () {
      final dt = DateTime(2021, 1, 31, 23, 59, 59, 999, 999);
      final startDt = DateTime(2021, 1, 31);
      expect(dt.startOfDay, startDt);
    });

    test('DateTimeExtra endOfDay', () {
      final dt = DateTime(2021, 1, 31);
      final endDt = DateTime(2021, 1, 31, 23, 59, 59, 999, 999);
      expect(dt.endOfDay, endDt);
    });

    test("Next Month", () {
      final dt = DateTime(2021, 10, 20);

      expect(dt.nextMonth(), DateTime(2021, 11, 1));
      expect(dt.nextMonth(2), DateTime(2021, 12, 1));
      expect(dt.nextMonth(3), DateTime(2022, 1, 1));
      expect(dt.nextMonth(4), DateTime(2022, 2, 1));

      expect(dt.nextMonth(-1), DateTime(2021, 9, 1));
    });

    test("Next Day", () {
      final dt = DateTime(2021, 10, 20, 1, 1);

      expect(dt.nextDay(), DateTime(2021, 10, 21));
      expect(dt.nextDay(2), DateTime(2021, 10, 22));
      expect(dt.nextDay(12), DateTime(2021, 11, 1));
      expect(dt.nextDay(-1), DateTime(2021, 10, 19));
    });
  });

  group("compare", () {
    test("compare year", () {
      final dt = DateTime(2021, 10, 20, 1, 1, 1, 1, 1);

      final dt2 = dt.copyWith(year: dt.year + 1);
      expect(dt.compareWith(dt2, DatetimeType.year), -1);
      expect(dt.equalTo(dt2, DatetimeType.year), false);

      final dt3 = dt.copyWith(year: dt.year - 1);
      expect(dt.compareWith(dt3, DatetimeType.year), 1);
      expect(dt.equalTo(dt3, DatetimeType.year), false);

      final dt4 = DateTime(dt.year);
      expect(dt.compareWith(dt4, DatetimeType.year), 0);
      expect(dt.equalTo(dt4, DatetimeType.year), true);
    });

    test("compare month", () {
      final dt = DateTime(2021, 10, 20, 1, 1, 1, 1, 1);

      final dt2 = dt.copyWith(month: dt.month + 1);
      expect(dt.compareWith(dt2, DatetimeType.month), -1);
      expect(dt.equalTo(dt2, DatetimeType.month), false);

      final dt3 = dt.copyWith(month: dt.month - 1);
      expect(dt.compareWith(dt3, DatetimeType.month), 1);
      expect(dt.equalTo(dt3, DatetimeType.month), false);

      final dt4 = dt.copyWith(year: dt.year, month: dt.month);
      expect(dt.compareWith(dt4, DatetimeType.month), 0);
      expect(dt.equalTo(dt4, DatetimeType.month), true);
    });

    test("compare day", () {
      final dt = DateTime(2021, 10, 20, 1, 1, 1, 1, 1);

      final dt2 = dt.copyWith(day: dt.day + 1);
      expect(dt.compareWith(dt2, DatetimeType.day), -1);
      expect(dt.equalTo(dt2, DatetimeType.day), false);

      final dt3 = dt.copyWith(day: dt.day - 1);
      expect(dt.compareWith(dt3, DatetimeType.day), 1);
      expect(dt.equalTo(dt3, DatetimeType.day), false);

      final dt4 = dt.startOfDay.copyWith(day: dt.day);
      expect(dt.compareWith(dt4, DatetimeType.day), 0);
      expect(dt.equalTo(dt4, DatetimeType.day), true);
    });

    test("compare hour", () {
      final dt = DateTime(2021, 10, 20, 1, 1, 1, 1, 1);

      final dt2 = dt.copyWith(hour: dt.hour + 1);
      expect(dt.compareWith(dt2, DatetimeType.hour), -1);
      expect(dt.equalTo(dt2, DatetimeType.hour), false);

      final dt3 = dt.copyWith(hour: dt.hour - 1);
      expect(dt.compareWith(dt3, DatetimeType.hour), 1);
      expect(dt.equalTo(dt3, DatetimeType.hour), false);

      final dt4 = dt.startOfDay.copyWith(hour: dt.hour);
      expect(dt.compareWith(dt4, DatetimeType.hour), 0);
      expect(dt.equalTo(dt4, DatetimeType.hour), true);
    });

    test("compare minute", () {
      final dt = DateTime(2021, 10, 20, 1, 1, 1, 1, 1);

      final dt2 = dt.copyWith(minute: dt.minute + 1);
      expect(dt.compareWith(dt2, DatetimeType.minute), -1);
      expect(dt.equalTo(dt2, DatetimeType.minute), false);

      final dt3 = dt.copyWith(minute: dt.minute - 1);
      expect(dt.compareWith(dt3, DatetimeType.minute), 1);
      expect(dt.equalTo(dt3, DatetimeType.minute), false);

      final dt4 = dt.startOfDay.copyWith(minute: dt.minute, hour: dt.hour);
      expect(dt.compareWith(dt4, DatetimeType.minute), 0);
      expect(dt.equalTo(dt4, DatetimeType.minute), true);
    });

    test("compare second", () {
      final dt = DateTime(2021, 10, 20, 1, 1, 1, 1, 1);

      final dt2 = dt.copyWith(second: dt.second + 1);
      expect(dt.compareWith(dt2, DatetimeType.second), -1);
      expect(dt.equalTo(dt2, DatetimeType.second), false);

      final dt3 = dt.copyWith(second: dt.second - 1);
      expect(dt.compareWith(dt3, DatetimeType.second), 1);
      expect(dt.equalTo(dt3, DatetimeType.second), false);

      final dt4 = dt.startOfDay
          .copyWith(second: dt.second, minute: dt.minute, hour: dt.hour);
      expect(dt.compareWith(dt4, DatetimeType.second), 0);
      expect(dt.equalTo(dt4, DatetimeType.second), true);
    });

    test("millisecond", () {
      final dt = DateTime(2021, 10, 20, 1, 1, 1, 1, 1);

      final dt2 = dt.copyWith(millisecond: dt.millisecond + 1);
      expect(dt.compareWith(dt2, DatetimeType.millisecond), -1);
      expect(dt.equalTo(dt2, DatetimeType.millisecond), false);

      final dt3 = dt.copyWith(millisecond: dt.millisecond - 1);
      expect(dt.compareWith(dt3, DatetimeType.millisecond), 1);
      expect(dt.equalTo(dt3, DatetimeType.millisecond), false);

      final dt4 = dt.startOfDay.copyWith(
          millisecond: dt.millisecond,
          second: dt.second,
          minute: dt.minute,
          hour: dt.hour);
      expect(dt.compareWith(dt4, DatetimeType.millisecond), 0);
      expect(dt.equalTo(dt4, DatetimeType.millisecond), true);
    });

    test("microsecond", () {
      final dt = DateTime(2021, 10, 20, 1, 1, 1, 1, 1);

      final dt2 = dt.copyWith(microsecond: dt.microsecond + 1);
      expect(dt.compareWith(dt2, DatetimeType.microsecond), -1);
      expect(dt.equalTo(dt2, DatetimeType.microsecond), false);

      final dt3 = dt.copyWith(microsecond: dt.microsecond - 1);
      expect(dt.compareWith(dt3, DatetimeType.microsecond), 1);
      expect(dt.equalTo(dt3, DatetimeType.microsecond), false);

      final dt4 = dt.startOfDay.copyWith(
          microsecond: dt.microsecond,
          millisecond: dt.millisecond,
          second: dt.second,
          minute: dt.minute,
          hour: dt.hour);
      expect(dt.compareWith(dt4, DatetimeType.microsecond), 0);
      expect(dt.equalTo(dt4, DatetimeType.microsecond), true);
    });
  });
}
