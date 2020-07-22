import 'dart:convert';

import 'package:kana_kit/kana_kit.dart';
import 'package:meta/meta.dart';
import 'package:test/test.dart';

import 'test_utils.dart';

typedef Converter = String Function(String input);
typedef ConverterTest = void Function({
  @required String input,
  @required String expected,
});
typedef ConverterAssertionTest = void Function(String input);

ConverterTest testConverter(Converter converter) {
  return ({input, expected}) {
    return test(
      '${formatInput(input)} becomes ${formatInput(expected)}',
      () {
        expect(converter(input), expected);
      },
    );
  };
}

ConverterAssertionTest testConverterAssertion(Converter checker) {
  return (input) {
    return test(
      'throws AssertionError when input is ${formatInput(input)}',
      () {
        expect(
          () => checker(input),
          throwsA(isA<AssertionError>()),
        );
      },
    );
  };
}

void main() {
  const kanaKit = KanaKit();
  group('conversions', () {
    group('toRomaji', () {
      final testToRomajiAssertion = testConverterAssertion(kanaKit.toRomaji);
      testToRomajiAssertion(null);

      final testToRomaji = testConverter(kanaKit.toRomaji);
      testToRomaji(input: '', expected: '');

      group('(upcaseKatakana: false)', () {
        final testToRomajiWithoutUpcase = testConverter(
          kanaKit.copyWithConfig(upcaseKatakana: false).toRomaji,
        );
        testToRomajiWithoutUpcase(
          input: 'ひらがな　カタカナ',
          expected: 'hiragana katakana',
        );
        testToRomajiWithoutUpcase(
          input: 'げーむ　ゲーム',
          expected: 'ge-mu geemu',
        );
      });
      group('(upcaseKatakana: true)', () {
        final testToRomajiWithUpcase = testConverter(
          kanaKit.copyWithConfig(upcaseKatakana: true).toRomaji,
        );
        testToRomajiWithUpcase(
          input: 'ひらがな　カタカナ',
          expected: 'hiragana KATAKANA',
        );
        testToRomajiWithUpcase(
          input: 'げーむ　ゲーム',
          expected: 'ge-mu GEEMU',
        );
      });
    });
    group('toKana', () {
      final testToKanaAssertion = testConverterAssertion(kanaKit.toKana);
      testToKanaAssertion(null);

      final testToKana = testConverter(kanaKit.toKana);
      testToKana(input: '', expected: '');

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
      final testToHiraganaAssertion =
          testConverterAssertion(kanaKit.toHiragana);
      testToHiraganaAssertion(null);

      final testToHiragana = testConverter(kanaKit.toHiragana);
      testToHiragana(input: '', expected: '');

      group('(passRomaji: false)', () {
        final testToHiraganaWithRomaji = testConverter(
          kanaKit.copyWithConfig(passRomaji: false).toHiragana,
        );
        testToHiraganaWithRomaji(
          input: 'toukyou, オオサカ',
          expected: 'とうきょう、　おおさか',
        );
        testToHiraganaWithRomaji(
          input: 'only カナ',
          expected: 'おんly　かな',
        );
        testToHiraganaWithRomaji(
          input: 'wi',
          expected: 'うぃ',
        );
      });
      group('(passRomaji: true)', () {
        final testToHiraganaWithoutRomaji = testConverter(
          kanaKit.copyWithConfig(passRomaji: true).toHiragana,
        );
        testToHiraganaWithoutRomaji(
          input: 'toukyou, オオサカ',
          expected: 'toukyou, おおさか',
        );
        testToHiraganaWithoutRomaji(
          input: 'only カナ',
          expected: 'only かな',
        );
        testToHiraganaWithoutRomaji(
          input: 'wi',
          expected: 'wi',
        );
      });
    });

    group('toKatakana', () {
      final testToKatakanaAssertion =
          testConverterAssertion(kanaKit.toKatakana);
      testToKatakanaAssertion(null);

      final testToKatakana = testConverter(kanaKit.toKatakana);
      testToKatakana(input: '', expected: '');

      group('(passRomaji: false)', () {
        final testToKatakanaWithRomaji = testConverter(
          kanaKit.copyWithConfig(passRomaji: false).toKatakana,
        );
        testToKatakanaWithRomaji(
          input: 'toukyou, おおさか',
          expected: 'トウキョウ、　オオサカ',
        );
        testToKatakanaWithRomaji(
          input: 'only かな',
          expected: 'オンly　カナ',
        );
        testToKatakanaWithRomaji(
          input: 'wi',
          expected: 'ウィ',
        );
      });
      group('(passRomaji: true)', () {
        final testToKatakanaWithoutRomaji = testConverter(
          kanaKit.copyWithConfig(passRomaji: true).toKatakana,
        );
        testToKatakanaWithoutRomaji(
          input: 'toukyou, おおさか',
          expected: 'toukyou, オオサカ',
        );
        testToKatakanaWithoutRomaji(
          input: 'only かな',
          expected: 'only カナ',
        );
        testToKatakanaWithoutRomaji(
          input: 'wi',
          expected: 'wi',
        );
      });
    });
  });
}
