// ignore: lines_longer_than_80_chars
// ignore_for_file: prefer_const_constructors, prefer_const_declarations, use_named_constants, avoid_redundant_argument_values
import 'package:checks/checks.dart';
import 'package:kana_kit/kana_kit.dart';
import 'package:test/test.dart';

void main() {
  group('KanaKitConfig', () {
    KanaKitConfig buildSubject({
      bool passRomaji = false,
      bool passKanji = true,
      bool upcaseKatakana = false,
    }) {
      return KanaKitConfig(
        passRomaji: passRomaji,
        passKanji: passKanji,
        upcaseKatakana: upcaseKatakana,
      );
    }

    test('supports value equality', () {
      check(buildSubject()).equals(buildSubject());
    });

    test('has correct hash code', () {
      final subject = buildSubject();
      check(subject).has((it) => it.hashCode, 'hashCode').equals(
            subject.passRomaji.hashCode ^
                subject.passKanji.hashCode ^
                subject.upcaseKatakana.hashCode,
          );
    });

    group('copyWith', () {
      test('returns same object when no arguments are provided', () {
        check(buildSubject().copyWith()).equals(buildSubject());
      });

      test('returns same object with updated passRomaji when provided', () {
        const initial = true;
        const changed = false;

        check(buildSubject(passRomaji: initial).copyWith(passRomaji: changed))
            .equals(buildSubject(passRomaji: changed));
      });

      test('returns same object with updated passKanji when provided', () {
        const initial = true;
        const changed = false;

        check(buildSubject(passKanji: initial).copyWith(passKanji: changed))
            .equals(buildSubject(passKanji: changed));
      });

      test('returns same object with updated upcaseKatakana when provided', () {
        const initial = true;
        const changed = false;

        check(
          buildSubject(upcaseKatakana: initial)
              .copyWith(upcaseKatakana: changed),
        ).equals(buildSubject(upcaseKatakana: changed));
      });
    });
  });
}
