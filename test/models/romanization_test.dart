import 'package:checks/checks.dart';
import 'package:kana_kit/kana_kit.dart';
import 'package:test/test.dart';

void main() {
  group('Romanization', () {
    test('supports value equality', () {
      check(Romanization.hepburn).equals(Romanization.hepburn);
    });

    test('.toString is correct', () {
      check(Romanization.hepburn.toString()).equals('Romanization(Hepburn)');
    });
  });
}
