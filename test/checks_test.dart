import 'package:kana_kit/kana_kit.dart';
import 'package:meta/meta.dart';
import 'package:test/test.dart';

typedef Checker = bool Function(String input);
typedef CheckerTest = void Function({
  @required String input,
  @required bool shouldPass,
});
CheckerTest testCheck(Checker checker, String checkResultName) {
  return ({input, shouldPass}) {
    return test(
      '"$input" IS ${!shouldPass ? 'NOT ' : ''}$checkResultName',
      () {
        expect(checker(input), shouldPass ? isTrue : isFalse);
      },
    );
  };
}

void main() {
  const kanaKit = KanaKit();
  group('checks', () {
    group('isRomaji', () {
      final testIsRomaji = testCheck(kanaKit.isRomaji, 'romaji');
      testIsRomaji(
        input: 'Tōkyō and Ōsaka',
        shouldPass: true,
      );
      testIsRomaji(
        input: '12a*b&c-d',
        shouldPass: true,
      );
      testIsRomaji(
        input: 'あアA',
        shouldPass: false,
      );
      testIsRomaji(
        input: 'お願い',
        shouldPass: false,
      );
      testIsRomaji(
        input: 'a！b&cーd',
        shouldPass: false,
      );
    });
    group('isJapanese', () {
      final testIsJapanese = testCheck(kanaKit.isJapanese, 'japanese');
      testIsJapanese(
        input: '泣き虫',
        shouldPass: true,
      );
      testIsJapanese(
        input: 'あア',
        shouldPass: true,
      );
      testIsJapanese(
        input: '２月',
        shouldPass: true,
      );
      testIsJapanese(
        input: '泣き虫。！〜＄',
        shouldPass: true,
      );
      testIsJapanese(
        input: '泣き虫.!~\$',
        shouldPass: false,
      );
      testIsJapanese(
        input: 'A泣き虫',
        shouldPass: false,
      );
    });
    group('isHiragana', () {
      final testIsHiragana = testCheck(kanaKit.isHiragana, 'hiragana');
      testIsHiragana(
        input: 'げーむ',
        shouldPass: true,
      );
      testIsHiragana(
        input: 'A',
        shouldPass: false,
      );
      testIsHiragana(
        input: 'あア',
        shouldPass: false,
      );
    });
    group('isKatakana', () {
      final testIsKatakana = testCheck(kanaKit.isKatakana, 'katakana');
      testIsKatakana(
        input: 'ゲーム',
        shouldPass: true,
      );
      testIsKatakana(
        input: 'A',
        shouldPass: false,
      );
      testIsKatakana(
        input: 'あ',
        shouldPass: false,
      );
      testIsKatakana(
        input: 'あア',
        shouldPass: false,
      );
    });
    group('isKanji', () {
      final testIsKanji = testCheck(kanaKit.isKanji, 'kanji');
      testIsKanji(
        input: '刀',
        shouldPass: true,
      );
      testIsKanji(
        input: '切腹',
        shouldPass: true,
      );
      testIsKanji(
        input: '勢い',
        shouldPass: false,
      );
      testIsKanji(
        input: 'あAア',
        shouldPass: false,
      );
      testIsKanji(
        input: '🐸',
        shouldPass: false,
      );
    });
    group('isMixed', () {
      group('(passKanji: true)', () {
        final testIsMixed = testCheck(
          kanaKit.copyWithConfig(passKanji: true).isMixed,
          'mixed',
        );
        testIsMixed(
          input: 'Abあア',
          shouldPass: true,
        );
        testIsMixed(
          input: 'お腹A',
          shouldPass: true,
        );
        testIsMixed(
          input: 'toukyou, おおさか',
          shouldPass: true,
        );
        testIsMixed(
          input: 'ab',
          shouldPass: false,
        );
        testIsMixed(
          input: 'あア',
          shouldPass: false,
        );
      });
      group('(passKanji: false)', () {
        final testIsMixed = testCheck(
          kanaKit.copyWithConfig(passKanji: false).isMixed,
          'mixed',
        );
        testIsMixed(
          input: 'Abあア',
          shouldPass: true,
        );
        testIsMixed(
          input: 'お腹A',
          shouldPass: false,
        );
        testIsMixed(
          input: 'toukyou, おおさか',
          shouldPass: true,
        );
        testIsMixed(
          input: 'ab',
          shouldPass: false,
        );
        testIsMixed(
          input: 'あア',
          shouldPass: false,
        );
      });
    });
  });
}
