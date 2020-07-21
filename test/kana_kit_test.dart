import 'package:test/test.dart';

import 'package:kana_kit/kana_kit.dart';

void main() {
  test('example test', () {
    final kit = Calculator();
    expect(kit.addOne(2), 3);
    expect(kit.addOne(-7), -6);
    expect(kit.addOne(0), 1);
    expect(() => kit.addOne(null), throwsNoSuchMethodError);
  });
}
