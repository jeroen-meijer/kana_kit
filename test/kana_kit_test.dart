import 'package:kana_kit/kana_kit.dart';
import 'package:test/test.dart';

// TODO: Improve tests and add tests for other configs.

void main() {
  const config = KanaKitConfig.defaultConfig;
  const kanaKit = KanaKit(config: config);
  group('KanaKit (default config)', () {
    group('checks', () {
      group('isRomaji', () {
        test('"Tōkyō and Ōsaka" IS romaji', () {
          expect(kanaKit.isRomaji('Tōkyō and Ōsaka'), isTrue);
        });
        test('"12a*b&c-d" IS romaji', () {
          expect(kanaKit.isRomaji('12a*b&c-d'), isTrue);
        });
        test('"あアA" IS NOT romaji', () {
          expect(kanaKit.isRomaji('あアA'), isFalse);
        });
        test('"お願い" IS NOT romaji', () {
          expect(kanaKit.isRomaji('お願い'), isFalse);
        });
        test('"a！b&cーd" IS NOT romaji', () {
          expect(kanaKit.isRomaji('a！b&cーd'), isFalse);
        });
      });
      group('isJapanese', () {
        test('"泣き虫" IS japanese', () {
          expect(kanaKit.isJapanese('泣き虫'), isTrue);
        });
        test('"あア" IS japanese', () {
          expect(kanaKit.isJapanese('あア'), isTrue);
        });
        test('"２月" IS japanese', () {
          expect(kanaKit.isJapanese('２月'), isTrue);
        });
        test('"泣き虫。！〜＄" IS japanese', () {
          expect(kanaKit.isJapanese('泣き虫。！〜＄'), isTrue);
        });
        test('"泣き虫.!~\$" IS NOT japanese', () {
          expect(kanaKit.isJapanese('泣き虫.!~\$'), isFalse);
        });
        test('"A泣き虫" IS NOT japanese', () {
          expect(kanaKit.isJapanese('A泣き虫'), isFalse);
        });
      });
      group('isHiragana', () {
        test('"げーむ" IS hiragana', () {
          expect(kanaKit.isHiragana('げーむ'), isTrue);
        });
        test('"A" IS NOT hiragana', () {
          expect(kanaKit.isHiragana('A'), isFalse);
        });
        test('"あア" IS NOT hiragana', () {
          expect(kanaKit.isHiragana('あア'), isFalse);
        });
      });
      group('isKatakana', () {
        test('"ゲーム" IS katakana', () {
          expect(kanaKit.isKatakana('ゲーム'), isTrue);
        });
        test('"A" IS NOT katakana', () {
          expect(kanaKit.isKatakana('A'), isFalse);
        });
        test('"あ" IS NOT katakana', () {
          expect(kanaKit.isKatakana('あ'), isFalse);
        });
        test('"あア" IS NOT katakana', () {
          expect(kanaKit.isKatakana('あア'), isFalse);
        });
      });
      group('isKanji', () {
        test('"刀" IS kanji', () {
          expect(kanaKit.isKanji('刀'), isTrue);
        });
        test('"切腹" IS kanji', () {
          expect(kanaKit.isKanji('切腹'), isTrue);
        });
        test('"勢い" IS NOT kanji', () {
          expect(kanaKit.isKanji('勢い'), isFalse);
        });
        test('"あAア" IS NOT kanji', () {
          expect(kanaKit.isKanji('あAア'), isFalse);
        });
        test('"🐸" IS NOT kanji', () {
          expect(kanaKit.isKanji('🐸'), isFalse);
        });
      });
      group('isMixed', () {
        test('"Abあア" IS mixed', () {
          expect(kanaKit.isMixed('Abあア'), isTrue);
        });
        test('"お腹A" IS mixed', () {
          expect(kanaKit.isMixed('お腹A'), isTrue);
        });
        test('"ab" IS NOT mixed', () {
          expect(kanaKit.isMixed('ab'), isFalse);
        });
        test('"あア" IS NOT mixed', () {
          expect(kanaKit.isMixed('あア'), isFalse);
        });
      });
    });

    group('conversions', () {
      group('toRomaji', () {
        test('"ひらがな　カタカナ" becomes "hiragana katakana"', () {
          expect(kanaKit.toRomaji('ひらがな　カタカナ'), 'hiragana katakana');
        });
        test('"げーむ　ゲーム" becomes "ge-mu geemu"', () {
          expect(kanaKit.toRomaji('げーむ　ゲーム'), 'ge-mu geemu');
        });
      });
      group('toKana', () {
        test('"onaji BUTTSUUJI" becomes "おなじ ブッツウジ"', () {
          expect(kanaKit.toKana('onaji BUTTSUUJI'), 'おなじ ブッツウジ');
        });
        test('"ONAJI buttsuuji" becomes "オナジ ぶっつうじ"', () {
          expect(kanaKit.toKana('ONAJI buttsuuji'), 'オナジ ぶっつうじ');
        });
        test('"座禅‘zazen’スタイル" becomes "座禅「ざぜん」スタイル"', () {
          expect(kanaKit.toKana('座禅‘zazen’スタイル'), '座禅「ざぜん」スタイル');
        });
        test('"batsuge-mu" becomes "ばつげーむ"', () {
          expect(kanaKit.toKana('batsuge-mu'), 'ばつげーむ');
        });
        test('"!?.:/,~-‘’“”[](){}" becomes "！？。：・、〜ー「」『』［］（）｛｝"', () {
          expect(kanaKit.toKana('!?.:/,~-‘’“”[](){}'), '！？。：・、〜ー「」『』［］（）｛｝');
        });
      });

      group('toHiragana', () {
        test('"toukyou, オオサカ" becomes "とうきょう、　おおさか"', () {
          expect(kanaKit.toHiragana('toukyou, オオサカ'), 'とうきょう、　おおさか');
        });
        test('"only カナ" becomes "only かな"', () {
          expect(kanaKit.toHiragana('only カナ'), 'only かな');
        });
        test('"wi" becomes "うぃ"', () {
          expect(kanaKit.toHiragana('wi'), 'うぃ');
        });
      });

      group('toKatakana', () {
        test('"toukyou, おおさか" becomes "トウキョウ、　オオサカ"', () {
          expect(kanaKit.toKatakana('toukyou, おおさか'), 'トウキョウ、　オオサカ');
        });
        test('"only かな" becomes "only カナ"', () {
          expect(kanaKit.toKatakana('only かな'), 'only カナ');
        });
        test('"wi" becomes "ウィ"', () {
          expect(kanaKit.toKatakana('wi'), 'ウィ');
        });
      });
    });
  });
}
