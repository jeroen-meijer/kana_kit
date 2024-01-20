import 'package:kana_kit/kana_kit.dart';
import 'package:test/test.dart';

import 'test_utils.dart';

typedef Converter = String Function(String input);
typedef ConverterTest = void Function({
  required String input,
  String? shouldBecome,
  String? shouldNotBecome,
});
typedef ConverterAssertionTest = void Function(String input);

ConverterTest converterTest(Converter converter) {
  return ({required input, shouldBecome, shouldNotBecome}) {
    if (shouldNotBecome != null) {
      final shouldChange = input == shouldNotBecome;
      return test(
        shouldChange
            ? '${formatInput(input)} should change'
            : '${formatInput(input)} does NOT become '
                '${formatInput(shouldNotBecome)}',
        () {
          expect(converter(input), isNot(shouldBecome));
        },
      );
    } else {
      final shouldNotChange = input == shouldBecome;
      return test(
        shouldNotChange
            ? '${formatInput(input)} should return the same'
            : '${formatInput(input)} becomes ${formatInput(shouldBecome)}',
        () {
          expect(converter(input), shouldBecome);
        },
      );
    }
  };
}

ConverterAssertionTest converterAssertionTest(Converter checker) {
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
      group('(upcaseKatakana: false)', () {
        final the = converterTest(
          kanaKit.copyWithConfig(upcaseKatakana: false).toRomaji,
        );
        the(input: '', shouldBecome: '');
        the(input: '.', shouldBecome: '.');
        the(input: 'hello', shouldBecome: 'hello');
        the(input: 'ひらがな　カタカナ', shouldBecome: 'hiragana katakana');
        the(input: 'げーむ　ゲーム', shouldBecome: 'ge-mu geemu');
        the(input: 'ワニカニ　ガ　スゴイ　ダ', shouldBecome: 'wanikani ga sugoi da');
        the(input: 'わにかに　が　すごい　だ', shouldBecome: 'wanikani ga sugoi da');
        the(input: 'ワニカニ　が　すごい　だ', shouldBecome: 'wanikani ga sugoi da');
        the(input: 'ばつげーむ', shouldBecome: 'batsuge-mu');
        the(input: '一抹げーむ', shouldBecome: '一抹ge-mu');
        the(input: 'スーパー', shouldBecome: 'suupaa');
        the(input: '缶コーヒー', shouldBecome: '缶koohii');
        the(input: 'わにかにがすごいだ', shouldNotBecome: 'wanikani ga sugoi da');
        the(input: 'きんにくまん', shouldBecome: 'kinnikuman');
        the(input: 'んんにんにんにゃんやん', shouldBecome: "nnninninnyan'yan");
        the(
          input: 'かっぱ　たった　しゅっしゅ ちゃっちゃ　やっつ',
          shouldBecome: 'kappa tatta shusshu chatcha yattsu',
        );
        group('small kana', () {
          the(input: 'っ', shouldBecome: '');
          the(input: 'ヶ', shouldBecome: 'ヶ');
          the(input: 'ヵ', shouldBecome: 'ヵ');
          the(input: 'ゃ', shouldBecome: 'ya');
          the(input: 'ゅ', shouldBecome: 'yu');
          the(input: 'ょ', shouldBecome: 'yo');
          the(input: 'ぁ', shouldBecome: 'a');
          the(input: 'ぃ', shouldBecome: 'i');
          the(input: 'ぅ', shouldBecome: 'u');
          the(input: 'ぇ', shouldBecome: 'e');
          the(input: 'ぉ', shouldBecome: 'o');
        });
        group('consonant-vowel combo', () {
          the(input: 'おんよみ', shouldBecome: "on'yomi");
          the(input: 'んよ んあ んゆ', shouldBecome: "n'yo n'a n'yu");
          the(input: 'シンヨ', shouldBecome: "shin'yo");
        });
      });
      group('(upcaseKatakana: true)', () {
        final the = converterTest(
          kanaKit.copyWithConfig(upcaseKatakana: true).toRomaji,
        );
        the(input: '', shouldBecome: '');
        the(input: '.', shouldBecome: '.');
        the(input: 'hello', shouldBecome: 'hello');
        the(input: 'ひらがな　カタカナ', shouldBecome: 'hiragana KATAKANA');
        the(input: 'げーむ　ゲーム', shouldBecome: 'ge-mu GEEMU');
        the(input: 'ワニカニ　ガ　スゴイ　ダ', shouldBecome: 'WANIKANI GA SUGOI DA');
        the(input: 'わにかに　が　すごい　だ', shouldBecome: 'wanikani ga sugoi da');
        the(input: 'ワニカニ　が　すごい　だ', shouldBecome: 'WANIKANI ga sugoi da');
        the(input: 'ばつげーむ', shouldBecome: 'batsuge-mu');
        the(input: '一抹げーむ', shouldBecome: '一抹ge-mu');
        the(input: 'スーパー', shouldBecome: 'SUUPAA');
        the(input: '缶コーヒー', shouldBecome: '缶KOOHII');
        the(input: 'わにかにがすごいだ', shouldNotBecome: 'WANIKANI GA SUGOI DA');
        the(input: 'きんにくまん', shouldBecome: 'kinnikuman');
        the(input: 'んんにんにんにゃんやん', shouldBecome: "nnninninnyan'yan");
        the(
          input: 'かっぱ　たった　しゅっしゅ ちゃっちゃ　やっつ',
          shouldBecome: 'kappa tatta shusshu chatcha yattsu',
        );
        group('small kana', () {
          the(input: 'っ', shouldBecome: '');
          the(input: 'ヶ', shouldBecome: 'ヶ');
          the(input: 'ヵ', shouldBecome: 'ヵ');
          the(input: 'ゃ', shouldBecome: 'ya');
          the(input: 'ゅ', shouldBecome: 'yu');
          the(input: 'ょ', shouldBecome: 'yo');
          the(input: 'ぁ', shouldBecome: 'a');
          the(input: 'ぃ', shouldBecome: 'i');
          the(input: 'ぅ', shouldBecome: 'u');
          the(input: 'ぇ', shouldBecome: 'e');
          the(input: 'ぉ', shouldBecome: 'o');
        });
        group('consonant-vowel combo', () {
          the(input: 'おんよみ', shouldBecome: "on'yomi");
          the(input: 'んよ んあ んゆ', shouldBecome: "n'yo n'a n'yu");
          the(input: 'シンヨ', shouldBecome: "SHIN'YO");
        });
      });
    });
    group('toKana', () {
      final the = converterTest(kanaKit.toKana);
      the(input: '', shouldBecome: '');
      the(input: '.', shouldBecome: '。');
      the(input: 'onaji', shouldBecome: 'おなじ');
      the(input: 'buttsuuji', shouldBecome: 'ぶっつうじ');
      the(input: 'ONAJI', shouldBecome: 'オナジ');
      the(input: 'BUTTSUUJI', shouldBecome: 'ブッツウジ');
      the(input: 'onaji BUTTSUUJI', shouldBecome: 'おなじ　ブッツウジ');
      the(input: 'ONAJI buttsuuji', shouldBecome: 'オナジ　ぶっつうじ');
      the(input: '座禅‘zazen’スタイル', shouldBecome: '座禅「ざぜん」スタイル');
      the(input: 'batsuge-mu', shouldBecome: 'ばつげーむ');
      the(input: '!?.:/,~-‘’“”[](){}', shouldBecome: '！？。：・、〜ー「」『』［］（）｛｝');
      the(input: 'WaniKani', shouldBecome: 'わにかに');
      the(input: '座禅‘zazen’スタイル', shouldBecome: '座禅「ざぜん」スタイル');
      the(input: 'n', shouldBecome: 'ん');
      the(input: 'shin', shouldBecome: 'しん');
      the(input: 'nn', shouldBecome: 'んん');
      the(input: 'wi', shouldBecome: 'うぃ');
      the(input: 'WI', shouldBecome: 'ウィ');
      the(
        input: r'ワニカニ AiUeO 鰐蟹 12345 @#\$%',
        shouldBecome: r'ワニカニ　アいウえオ　鰐蟹　12345　@#\$%',
      );
    });

    group('toHiragana', () {
      group('(passRomaji: false)', () {
        final the = converterTest(
          kanaKit.copyWithConfig(passRomaji: false).toHiragana,
        );
        the(input: '', shouldBecome: '');
        the(input: '.', shouldBecome: '。');
        the(input: 'wi', shouldBecome: 'うぃ');
        the(input: 'スーパー', shouldBecome: 'すうぱあ');
        the(input: 'バンゴー', shouldBecome: 'ばんごう');
        the(input: 'only カナ', shouldBecome: 'おんly　かな');
        the(input: 'toukyou, オオサカ', shouldBecome: 'とうきょう、　おおさか');
        the(input: 'IROHANIHOHETO', shouldBecome: 'いろはにほへと');
        the(input: 'CHIRINURUWO', shouldBecome: 'ちりぬるを');
        the(input: 'WAKAYOTARESO', shouldBecome: 'わかよたれそ');
        the(input: 'TSUNENARAMU', shouldBecome: 'つねならむ');
        the(input: 'KEFUKOETE', shouldBecome: 'けふこえて');
        the(input: 'ASAKIYUMEMISHI', shouldBecome: 'あさきゆめみし');
        the(input: 'NLTU', shouldBecome: 'んっ');
      });
      group('(passRomaji: true)', () {
        final the = converterTest(
          kanaKit.copyWithConfig(passRomaji: true).toHiragana,
        );

        the(input: '', shouldBecome: '');
        the(input: '.', shouldBecome: '.');
        the(input: 'wi', shouldBecome: 'wi');
        the(input: 'スーパー', shouldBecome: 'すうぱあ');
        the(input: 'バンゴー', shouldBecome: 'ばんごう');
        the(input: 'only カナ', shouldBecome: 'only かな');
        the(input: 'toukyou, オオサカ', shouldBecome: 'toukyou, おおさか');
        the(input: 'IROHANIHOHETO', shouldBecome: 'IROHANIHOHETO');
        the(input: 'CHIRINURUWO', shouldBecome: 'CHIRINURUWO');
        the(input: 'WAKAYOTARESO', shouldBecome: 'WAKAYOTARESO');
        the(input: 'TSUNENARAMU', shouldBecome: 'TSUNENARAMU');
        the(input: 'KEFUKOETE', shouldBecome: 'KEFUKOETE');
        the(input: 'ASAKIYUMEMISHI', shouldBecome: 'ASAKIYUMEMISHI');
        the(input: 'NLTU', shouldBecome: 'NLTU');
      });
    });

    group('toKatakana', () {
      group('(passRomaji: false)', () {
        final the = converterTest(
          kanaKit.copyWithConfig(passRomaji: false).toKatakana,
        );
        the(input: '', shouldBecome: '');
        the(input: 'ー', shouldBecome: 'ー');
        the(input: '.', shouldBecome: '。');
        the(input: 'wi', shouldBecome: 'ウィ');
        the(input: 'すうぱあ', shouldBecome: 'スウパア');
        the(input: 'ばんごう', shouldBecome: 'バンゴウ');
        the(input: 'only かな', shouldBecome: 'オンly　カナ');
        the(input: 'toukyou, おおさか', shouldBecome: 'トウキョウ、　オオサカ');
        the(input: 'IROHANIHOHETO', shouldBecome: 'イロハニホヘト');
        the(input: 'CHIRINURUWO', shouldBecome: 'チリヌルヲ');
        the(input: 'WAKAYOTARESO', shouldBecome: 'ワカヨタレソ');
        the(input: 'TSUNENARAMU', shouldBecome: 'ツネナラム');
        the(input: 'KEFUKOETE', shouldBecome: 'ケフコエテ');
        the(input: 'ASAKIYUMEMISHI', shouldBecome: 'アサキユメミシ');
        the(input: 'NLTU', shouldBecome: 'ンッ');
      });
      group('(passRomaji: true)', () {
        final the = converterTest(
          kanaKit.copyWithConfig(passRomaji: true).toKatakana,
        );

        the(input: '', shouldBecome: '');
        the(input: 'ー', shouldBecome: 'ー');
        the(input: '.', shouldBecome: '.');
        the(input: 'wi', shouldBecome: 'wi');
        the(input: 'すうぱあ', shouldBecome: 'スウパア');
        the(input: 'ばんごう', shouldBecome: 'バンゴウ');
        the(input: 'only かな', shouldBecome: 'only カナ');
        the(input: 'toukyou, おおさか', shouldBecome: 'toukyou, オオサカ');
        the(input: 'IROHANIHOHETO', shouldBecome: 'IROHANIHOHETO');
        the(input: 'CHIRINURUWO', shouldBecome: 'CHIRINURUWO');
        the(input: 'WAKAYOTARESO', shouldBecome: 'WAKAYOTARESO');
        the(input: 'TSUNENARAMU', shouldBecome: 'TSUNENARAMU');
        the(input: 'KEFUKOETE', shouldBecome: 'KEFUKOETE');
        the(input: 'ASAKIYUMEMISHI', shouldBecome: 'ASAKIYUMEMISHI');
        the(input: 'NLTU', shouldBecome: 'NLTU');
      });
    });
  });
}
