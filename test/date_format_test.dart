import 'package:test/test.dart';
import 'package:sutil/sutil.dart' show Format, Tick;

void main() {
  group('Tick', () {
    test('Tick format', () {
      final date = DateTime(2021, 10, 20, 1, 1, 1);
      final tick = Tick(date.millisecondsSinceEpoch);
      expect(tick.date, DateTime(2021, 10, 20, 1, 1, 1));
      expect(tick.format(), '2021-10-20 01:01:01');
      expect(tick.format('yyyy/MM/dd HH:mm'), '2021/10/20 01:01');
    });

    test('Tick parse', () {
      final date = '2021-10-20 01:01:01';
      final tick = Tick.tryParse(date);
      expect(tick?.date, DateTime(2021, 10, 20, 1, 1, 1));
    });

    test('Tick parse format', () {
      final date = '2021-10-20 01:01:01';
      final layout = 'yyyy-MM-dd HH:mm:ss';
      final tick = Tick.tryParse(date, layout);
      expect(tick?.date, DateTime(2021, 10, 20, 1, 1, 1));
    });
  });

  group('Date tests', () {
    test('Format date', () {
      final date = DateTime(2021, 10, 20, 1, 1, 1, 1, 1);
      expect(Format.f(date.millisecondsSinceEpoch), '2021年10月20日');
      expect(Format.f(date.millisecondsSinceEpoch, 'yyyy年MM月dd日 HH:mm'), '2021年10月20日 01:01');
    });

    test('Parse date', () {
      final date = '2021年10月20日';
      expect(Format.p(date), DateTime(2021, 10, 20).millisecondsSinceEpoch);
    });
  });

  group("rf", () {
    // 刚刚
    test("rf", () {
      final date = DateTime.now().millisecondsSinceEpoch;
      expect(Format.rf(date), '刚刚');
    });

    // 1分钟前
    test("rf", () {
      final date = DateTime.now().subtract(Duration(minutes: 1)).millisecondsSinceEpoch;
      expect(Format.rf(date), '1分钟前');
    });

    // 1小时前
    test("rf", () {
      final date = DateTime.now().subtract(Duration(hours: 1)).millisecondsSinceEpoch;
      expect(Format.rf(date), '1小时前');
      final date1 = DateTime.now().subtract(Duration(hours: 3, minutes: 59, seconds: 59)).millisecondsSinceEpoch;
      expect(Format.rf(date1), '3小时前');
    });

    // 今天 HH:mm
    test("rf", () {
      final date = DateTime.now().subtract(Duration(hours: 4)).millisecondsSinceEpoch;
      expect(Format.rf(date), Format.f(date, 'HH:mm'));
    });

    // 昨天 HH:mm
    test("rf", () {
      final now = DateTime.now();
      final date = now.subtract(Duration(days: 1)).millisecondsSinceEpoch;

      expect(Format.rf(date), '昨天 ${Format.f(date, 'HH:mm')}');
    });

    // 一周内
    test("rf", () {
      final now = DateTime.now();
      final wd = now.subtract(Duration(days: 6));
      final date = wd.millisecondsSinceEpoch;

      expect(Format.rf(date), '${Format.weekdayName(wd.weekday)} ${Format.f(date, 'HH:mm')}');
    });
  });
}
