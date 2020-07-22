import 'package:kana_kit/kana_kit.dart';
import 'package:meta/meta.dart';
import 'package:test/test.dart';

import 'test_utils.dart';

typedef Checker = bool Function(String input);
typedef CheckerTest = void Function({
  @required String input,
  @required bool shouldPass,
});
typedef CheckerAssertionTest = void Function(String input);

CheckerTest testChecker(Checker checker, String checkResultName) {
  return ({input, shouldPass}) {
    return test(
      '${formatInput(input)} is ${!shouldPass ? 'NOT ' : ''}$checkResultName',
      () {
        expect(checker(input), shouldPass ? isTrue : isFalse);
      },
    );
  };
}

CheckerAssertionTest testCheckerAssertion(Checker checker) {
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
  group('checks', () {
    group('isRomaji', () {
      final testIsRomajiAssertion = testCheckerAssertion(kanaKit.isRomaji);
      testIsRomajiAssertion(null);
      testIsRomajiAssertion('');

      final testIsRomaji = testChecker(kanaKit.isRomaji, 'romaji');
      testIsRomaji(input: 'A', shouldPass: true);
      testIsRomaji(input: 'xYz', shouldPass: true);
      testIsRomaji(input: 'Tōkyō and Ōsaka', shouldPass: true);
      testIsRomaji(input: 'あアA', shouldPass: false);
      testIsRomaji(input: 'お願い', shouldPass: false);
      testIsRomaji(input: '熟成', shouldPass: false);
      testIsRomaji(input: 'a*b&c-d', shouldPass: true);
      testIsRomaji(input: '0123456789', shouldPass: true);
      testIsRomaji(input: 'a！b&cーd', shouldPass: false);
      testIsRomaji(input: 'ｈｅｌｌｏ', shouldPass: false);
    });
    group('isJapanese', () {
      final testIsJapaneseAssertion = testCheckerAssertion(kanaKit.isJapanese);
      testIsJapaneseAssertion(null);
      testIsJapaneseAssertion('');

      final testIsJapanese = testChecker(kanaKit.isJapanese, 'japanese');
      testIsJapanese(input: '泣き虫', shouldPass: true);
      testIsJapanese(input: 'あア', shouldPass: true);
      testIsJapanese(input: 'A泣き虫', shouldPass: false);
      testIsJapanese(input: 'A', shouldPass: false);
      testIsJapanese(input: '　', shouldPass: true);
      testIsJapanese(input: ' ', shouldPass: false);
      testIsJapanese(
        input: '泣き虫。＃！〜〈〉《》〔〕［］【】（）｛｝〝〟',
        shouldPass: true,
      );
      testIsJapanese(input: '泣き虫.!~', shouldPass: false);
      testIsJapanese(input: '０１２３４５６７８９', shouldPass: true);
      testIsJapanese(input: '0123456789', shouldPass: false);
      testIsJapanese(input: 'ＭｅＴｏｏ', shouldPass: true);
      testIsJapanese(input: '２０１１年', shouldPass: true);
      testIsJapanese(input: 'ﾊﾝｶｸｶﾀｶﾅ', shouldPass: true);
      testIsJapanese(
        input: '＃ＭｅＴｏｏ、これを前に「ＫＵＲＯＳＨＩＯ」は、'
            '都内で報道陣を前に水中探査ロボットの最終点検の様子を公開しました。'
            'イルカのような形をした探査ロボットは、全長３メートル、'
            '重さは３５０キロあります。《はじめに》冒頭、安倍総理大臣は、ことしが'
            '明治元年から１５０年にあたることに触れ「明治という新しい時代が育てたあまたの'
            '人材が、技術優位の欧米諸国が迫る『国難』とも呼ぶべき危機の中で、わが国が急速に'
            '近代化を遂げる原動力となった。今また、日本は少子高齢化という『国難』とも'
            '呼ぶべき危機に直面している。もう１度、あらゆる日本人にチャンスを創ることで、'
            '少子高齢化も克服できる」と呼びかけました。《働き方改革》続いて安倍総理大臣は、'
            '具体的な政策課題の最初に「働き方改革」を取り上げ、「戦後の労働基準法制定以来、'
            '７０年ぶりの大改革だ。誰もが生きがいを感じて、その能力を思う存分発揮すれば'
            '少子高齢化も克服できる」と述べました。そして、同一労働同一賃金の実現や、'
            '時間外労働の上限規制の導入、それに労働時間でなく成果で評価するとして労働時間の'
            '規制から外す「高度プロフェッショナル制度」の創設などに取り組む考えを'
            '強調しました。',
        shouldPass: true,
      );
    });
    group('isKana', () {
      final testIsKanaAssertion = testCheckerAssertion(kanaKit.isKana);
      testIsKanaAssertion(null);
      testIsKanaAssertion('');

      final testIsKana = testChecker(kanaKit.isKana, 'kana');
      testIsKana(input: 'あ', shouldPass: true);
      testIsKana(input: 'ア', shouldPass: true);
      testIsKana(input: 'あア', shouldPass: true);
      testIsKana(input: 'A', shouldPass: false);
      testIsKana(input: 'あAア', shouldPass: false);
      testIsKana(input: 'アーあ', shouldPass: true);
    });
    group('isHiragana', () {
      final testIsHiraganaAssertion = testCheckerAssertion(kanaKit.isHiragana);
      testIsHiraganaAssertion(null);
      testIsHiraganaAssertion('');

      final testIsHiragana = testChecker(kanaKit.isHiragana, 'hiragana');
      testIsHiragana(input: 'あ', shouldPass: true);
      testIsHiragana(input: 'ああ', shouldPass: true);
      testIsHiragana(input: 'ア', shouldPass: false);
      testIsHiragana(input: 'A', shouldPass: false);
      testIsHiragana(input: 'あア', shouldPass: false);
      testIsHiragana(input: 'げーむ', shouldPass: true);
    });
    group('isKatakana', () {
      final testIsKatakanaAssertion = testCheckerAssertion(kanaKit.isKatakana);
      testIsKatakanaAssertion(null);
      testIsKatakanaAssertion('');

      final testIsKatakana = testChecker(kanaKit.isKatakana, 'katakana');
      testIsKatakana(input: 'アア', shouldPass: true);
      testIsKatakana(input: 'ア', shouldPass: true);
      testIsKatakana(input: 'あ', shouldPass: false);
      testIsKatakana(input: 'A', shouldPass: false);
      testIsKatakana(input: 'あア', shouldPass: false);
      testIsKatakana(input: 'ゲーム', shouldPass: true);
    });

    group('isKanji', () {
      final testIsKanjiAssertion = testCheckerAssertion(kanaKit.isKanji);
      testIsKanjiAssertion(null);
      testIsKanjiAssertion('');

      final testIsKanji = testChecker(kanaKit.isKanji, 'kanji');
      testIsKanji(input: '切腹', shouldPass: true);
      testIsKanji(input: '刀', shouldPass: true);
      testIsKanji(input: '🐸', shouldPass: false);
      testIsKanji(input: 'あ', shouldPass: false);
      testIsKanji(input: 'ア', shouldPass: false);
      testIsKanji(input: 'あア', shouldPass: false);
      testIsKanji(input: 'A', shouldPass: false);
      testIsKanji(input: 'あAア', shouldPass: false);
      testIsKanji(input: '１２隻', shouldPass: false);
      testIsKanji(input: '12隻', shouldPass: false);
      testIsKanji(input: '隻。', shouldPass: false);
      testIsKanji(input: '🐸', shouldPass: false);
    });
    group('isMixed', () {
      final testIsMixedAssertion = testCheckerAssertion(kanaKit.isMixed);
      testIsMixedAssertion(null);
      testIsMixedAssertion('');

      group('(passKanji: true)', () {
        final testIsMixed = testChecker(
          kanaKit.copyWithConfig(passKanji: true).isMixed,
          'mixed',
        );
        testIsMixed(input: 'Aア', shouldPass: true);
        testIsMixed(input: 'Aあ', shouldPass: true);
        testIsMixed(input: 'Aあア', shouldPass: true);
        testIsMixed(input: '２あア', shouldPass: false);
        testIsMixed(input: 'お腹A', shouldPass: true);
        testIsMixed(input: 'お腹', shouldPass: false);
        testIsMixed(input: '腹', shouldPass: false);
        testIsMixed(input: 'A', shouldPass: false);
        testIsMixed(input: 'あ', shouldPass: false);
        testIsMixed(input: 'ア', shouldPass: false);
      });
      group('(passKanji: false)', () {
        final testIsMixed = testChecker(
          kanaKit.copyWithConfig(passKanji: false).isMixed,
          'mixed',
        );
        testIsMixed(input: 'Aア', shouldPass: true);
        testIsMixed(input: 'Aあ', shouldPass: true);
        testIsMixed(input: 'Aあア', shouldPass: true);
        testIsMixed(input: '２あア', shouldPass: false);
        testIsMixed(input: 'お腹A', shouldPass: false);
        testIsMixed(input: 'お腹', shouldPass: false);
        testIsMixed(input: '腹', shouldPass: false);
        testIsMixed(input: 'A', shouldPass: false);
        testIsMixed(input: 'あ', shouldPass: false);
        testIsMixed(input: 'ア', shouldPass: false);
      });
    });
  });
}
