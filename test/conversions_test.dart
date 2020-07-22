import 'package:kana_kit/kana_kit.dart';
import 'package:meta/meta.dart';
import 'package:test/test.dart';

typedef Converter = String Function(String input);
typedef ConverterTest = void Function({
  @required String input,
  @required String expected,
});

ConverterTest testConversion(Converter converter) {
  return ({input, expected}) {
    return test('"$input" becomes "$expected"', () {
      expect(converter(input), expected);
    });
  };
}

void main() {
  const kanaKit = KanaKit();
  group('conversions', () {
    group('toRomaji', () {
      group('(upcaseKatakana: false)', () {
        final testToRomaji = testConversion(
          kanaKit.copyWithConfig(upcaseKatakana: false).toRomaji,
        );
        testToRomaji(
          input: 'ひらがな　カタカナ',
          expected: 'hiragana katakana',
        );
        testToRomaji(
          input: 'げーむ　ゲーム',
          expected: 'ge-mu geemu',
        );
      });
      group('(upcaseKatakana: true)', () {
        final testToRomaji = testConversion(
          kanaKit.copyWithConfig(upcaseKatakana: true).toRomaji,
        );
        testToRomaji(
          input: 'ひらがな　カタカナ',
          expected: 'hiragana KATAKANA',
        );
        testToRomaji(
          input: 'げーむ　ゲーム',
          expected: 'ge-mu GEEMU',
        );
      });
    });
    group('toKana', () {
      final testToKana = testConversion(kanaKit.toKana);
      // test('t', () {
      //   expect(kanaKit.toKana('onaji BUTTSUUJI'), 'おなじ ブッツウジ');
      // });
      testToKana(
        input: 'onaji BUTTSUUJI',
        expected: 'おなじ　ブッツウジ',
      );
      testToKana(
        input: 'ONAJI buttsuuji',
        expected: 'オナジ　ぶっつうじ',
      );
      testToKana(
        input: '座禅‘zazen’スタイル',
        expected: '座禅「ざぜん」スタイル',
      );
      testToKana(
        input: 'batsuge-mu',
        expected: 'ばつげーむ',
      );
      testToKana(
        input: '!?.:/,~-‘’“”[](){}',
        expected: '！？。：・、〜ー「」『』［］（）｛｝',
      );
    });

    group('toHiragana', () {
      group('(passRomaji: false)', () {
        final testToHiragana = testConversion(
          kanaKit.copyWithConfig(passRomaji: false).toHiragana,
        );
        testToHiragana(
          input: 'toukyou, オオサカ',
          expected: 'とうきょう、　おおさか',
        );
        testToHiragana(
          input: 'only カナ',
          expected: 'おんly　かな',
        );
        testToHiragana(
          input: 'wi',
          expected: 'うぃ',
        );
      });
      group('(passRomaji: true)', () {
        final testToHiragana = testConversion(
          kanaKit.copyWithConfig(passRomaji: true).toHiragana,
        );
        testToHiragana(
          input: 'toukyou, オオサカ',
          expected: 'toukyou, おおさか',
        );
        testToHiragana(
          input: 'only カナ',
          expected: 'only かな',
        );
        testToHiragana(
          input: 'wi',
          expected: 'wi',
        );
      });
    });

    group('toKatakana', () {
      group('(passRomaji: false)', () {
        final testToKatakana = testConversion(
          kanaKit.copyWithConfig(passRomaji: false).toKatakana,
        );
        testToKatakana(
          input: 'toukyou, おおさか',
          expected: 'トウキョウ、　オオサカ',
        );
        testToKatakana(
          input: 'only かな',
          expected: 'オンly　カナ',
        );
        testToKatakana(
          input: 'wi',
          expected: 'ウィ',
        );
      });
      group('(passRomaji: true)', () {
        final testToKatakana = testConversion(
          kanaKit.copyWithConfig(passRomaji: true).toKatakana,
        );
        testToKatakana(
          input: 'toukyou, おおさか',
          expected: 'toukyou, オオサカ',
        );
        testToKatakana(
          input: 'only かな',
          expected: 'only カナ',
        );
        testToKatakana(
          input: 'wi',
          expected: 'wi',
        );
      });
    });
  });
}
