// ignore_for_file: prefer_const_constructors
import 'package:kana_kit/kana_kit.dart';
import 'package:test/test.dart';

const passRomaji = false;
const passKanji = true;
const upcaseKatakana = false;
const romanization = Romanization.hepburn;

void main() {
  group('KanaKitConfig', () {
    test('props are correct', () {
      final actual = KanaKitConfig(
        passRomaji: passRomaji,
        passKanji: passKanji,
        upcaseKatakana: upcaseKatakana,
      ).props;

      final expected = [
        passRomaji,
        passKanji,
        upcaseKatakana,
        romanization,
      ];

      expect(actual, expected);
    });
    group('constructor', () {});
    group('copyWith', () {
      test(
        'returns same object with updated passRomaji '
        'when passRomaji is provided',
        () {
          const initial = false;
          const changed = true;

          expect(
            KanaKitConfig(
              passRomaji: initial,
              passKanji: passKanji,
              upcaseKatakana: upcaseKatakana,
            ).copyWith(passRomaji: changed),
            KanaKitConfig(
              passRomaji: changed,
              passKanji: passKanji,
              upcaseKatakana: upcaseKatakana,
            ),
          );
        },
      );
      test(
        'returns same object with updated passKanji '
        'when passKanji is provided',
        () {
          const initial = true;
          const changed = false;

          expect(
            KanaKitConfig(
              passRomaji: passRomaji,
              passKanji: initial,
              upcaseKatakana: upcaseKatakana,
            ).copyWith(passKanji: changed),
            KanaKitConfig(
              passRomaji: passRomaji,
              passKanji: changed,
              upcaseKatakana: upcaseKatakana,
            ),
          );
        },
      );
      test(
        'returns same object with updated upcaseKatakana '
        'when upcaseKatakana is provided',
        () {
          const initial = false;
          const changed = true;

          expect(
            KanaKitConfig(
              passRomaji: passRomaji,
              passKanji: passKanji,
              upcaseKatakana: initial,
            ).copyWith(upcaseKatakana: changed),
            KanaKitConfig(
              passRomaji: passRomaji,
              passKanji: passKanji,
              upcaseKatakana: changed,
            ),
          );
        },
      );
    });
  });
}
