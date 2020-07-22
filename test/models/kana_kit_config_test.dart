import 'package:kana_kit/kana_kit.dart';
import 'package:test/test.dart';

const passRomaji = false;
const passKanji = true;
const upcaseKatakana = false;
const romanization = Romanization.hepburn;

void assertionTest({
  bool passRomaji = passRomaji,
  bool passKanji = passKanji,
  bool upcaseKatakana = upcaseKatakana,
}) {
  final nullField = <String, dynamic>{
    'passRomaji': passRomaji,
    'passKanji': passKanji,
    'upcaseKatakana': upcaseKatakana,
  }.entries.firstWhere((entry) => entry.value == null).key;

  return test('throws AssertionError when $nullField is null', () {
    expect(
      () => KanaKitConfig(
        passRomaji: passRomaji,
        passKanji: passKanji,
        upcaseKatakana: upcaseKatakana,
      ),
      throwsA(isA<AssertionError>()),
    );
  });
}

void main() {
  group('KanaKitConfig', () {
    test('props are correct', () {
      final actual = const KanaKitConfig(
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
    group('constructor', () {
      assertionTest(passRomaji: null);
      assertionTest(passKanji: null);
      assertionTest(upcaseKatakana: null);
    });
    group('copyWith', () {
      test(
        'returns same object with updated passRomaji'
        'when passRomaji is provided',
        () {
          final initial = false;
          final changed = true;

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
        'returns same object with updated passKanji'
        'when passKanji is provided',
        () {
          final initial = true;
          final changed = false;

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
        'returns same object with updated upcaseKatakana'
        'when upcaseKatakana is provided',
        () {
          final initial = false;
          final changed = true;

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
