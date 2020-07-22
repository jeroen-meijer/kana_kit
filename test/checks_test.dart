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

CheckerTest checkerTest(Checker checker, String checkResultName) {
  return ({input, shouldPass}) {
    return test(
      '${formatInput(input)} is ${!shouldPass ? 'NOT ' : ''}$checkResultName',
      () {
        expect(checker(input), shouldPass ? isTrue : isFalse);
      },
    );
  };
}

CheckerAssertionTest checkerAssertionTest(Checker checker) {
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
      final throwsAssertionErrorWithInputIs =
          checkerAssertionTest(kanaKit.isRomaji);
      throwsAssertionErrorWithInputIs(null);
      throwsAssertionErrorWithInputIs('');

      final the = checkerTest(kanaKit.isRomaji, 'romaji');
      the(input: 'A', shouldPass: true);
      the(input: 'xYz', shouldPass: true);
      the(input: 'Tōkyō and Ōsaka', shouldPass: true);
      the(input: 'あアA', shouldPass: false);
      the(input: 'お願い', shouldPass: false);
      the(input: '熟成', shouldPass: false);
      the(input: 'a*b&c-d', shouldPass: true);
      the(input: '0123456789', shouldPass: true);
      the(input: 'a！b&cーd', shouldPass: false);
      the(input: 'ｈｅｌｌｏ', shouldPass: false);
    });
    group('isJapanese', () {
      final throwsAssertionErrorWithInputIs =
          checkerAssertionTest(kanaKit.isJapanese);
      throwsAssertionErrorWithInputIs(null);
      throwsAssertionErrorWithInputIs('');

      final the = checkerTest(kanaKit.isJapanese, 'japanese');
      the(input: '泣き虫', shouldPass: true);
      the(input: 'あア', shouldPass: true);
      the(input: 'A泣き虫', shouldPass: false);
      the(input: 'A', shouldPass: false);
      the(input: '　', shouldPass: true);
      the(input: ' ', shouldPass: false);
      the(
        input: '泣き虫。＃！〜〈〉《》〔〕［］【】（）｛｝〝〟',
        shouldPass: true,
      );
      the(input: '泣き虫.!~', shouldPass: false);
      the(input: '０１２３４５６７８９', shouldPass: true);
      the(input: '0123456789', shouldPass: false);
      the(input: 'ＭｅＴｏｏ', shouldPass: true);
      the(input: '２０１１年', shouldPass: true);
      the(input: 'ﾊﾝｶｸｶﾀｶﾅ', shouldPass: true);
      the(
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
      final throwsAssertionErrorWithInputIs =
          checkerAssertionTest(kanaKit.isKana);
      throwsAssertionErrorWithInputIs(null);
      throwsAssertionErrorWithInputIs('');

      final the = checkerTest(kanaKit.isKana, 'kana');
      the(input: 'あ', shouldPass: true);
      the(input: 'ア', shouldPass: true);
      the(input: 'あア', shouldPass: true);
      the(input: 'A', shouldPass: false);
      the(input: 'あAア', shouldPass: false);
      the(input: 'アーあ', shouldPass: true);
    });
    group('isHiragana', () {
      final throwsAssertionErrorWithInputIs =
          checkerAssertionTest(kanaKit.isHiragana);
      throwsAssertionErrorWithInputIs(null);
      throwsAssertionErrorWithInputIs('');

      final the = checkerTest(kanaKit.isHiragana, 'hiragana');
      the(input: 'あ', shouldPass: true);
      the(input: 'ああ', shouldPass: true);
      the(input: 'ア', shouldPass: false);
      the(input: 'A', shouldPass: false);
      the(input: 'あア', shouldPass: false);
      the(input: 'げーむ', shouldPass: true);
    });
    group('isKatakana', () {
      final throwsAssertionErrorWithInputIs =
          checkerAssertionTest(kanaKit.isKatakana);
      throwsAssertionErrorWithInputIs(null);
      throwsAssertionErrorWithInputIs('');

      final the = checkerTest(kanaKit.isKatakana, 'katakana');
      the(input: 'アア', shouldPass: true);
      the(input: 'ア', shouldPass: true);
      the(input: 'あ', shouldPass: false);
      the(input: 'A', shouldPass: false);
      the(input: 'あア', shouldPass: false);
      the(input: 'ゲーム', shouldPass: true);
    });

    group('isKanji', () {
      final throwsAssertionErrorWithInputIs =
          checkerAssertionTest(kanaKit.isKanji);
      throwsAssertionErrorWithInputIs(null);
      throwsAssertionErrorWithInputIs('');

      final the = checkerTest(kanaKit.isKanji, 'kanji');
      the(input: '切腹', shouldPass: true);
      the(input: '刀', shouldPass: true);
      the(input: '🐸', shouldPass: false);
      the(input: 'あ', shouldPass: false);
      the(input: 'ア', shouldPass: false);
      the(input: 'あア', shouldPass: false);
      the(input: 'A', shouldPass: false);
      the(input: 'あAア', shouldPass: false);
      the(input: '１２隻', shouldPass: false);
      the(input: '12隻', shouldPass: false);
      the(input: '隻。', shouldPass: false);
      the(input: '🐸', shouldPass: false);
    });
    group('isMixed', () {
      final throwsAssertionErrorWithInputIs =
          checkerAssertionTest(kanaKit.isMixed);
      throwsAssertionErrorWithInputIs(null);
      throwsAssertionErrorWithInputIs('');

      group('(passKanji: true)', () {
        final the = checkerTest(
          kanaKit.copyWithConfig(passKanji: true).isMixed,
          'mixed',
        );
        the(input: 'Aア', shouldPass: true);
        the(input: 'Aあ', shouldPass: true);
        the(input: 'Aあア', shouldPass: true);
        the(input: '２あア', shouldPass: false);
        the(input: 'お腹A', shouldPass: true);
        the(input: 'お腹', shouldPass: false);
        the(input: '腹', shouldPass: false);
        the(input: 'A', shouldPass: false);
        the(input: 'あ', shouldPass: false);
        the(input: 'ア', shouldPass: false);
      });
      group('(passKanji: false)', () {
        final the = checkerTest(
          kanaKit.copyWithConfig(passKanji: false).isMixed,
          'mixed',
        );
        the(input: 'Aア', shouldPass: true);
        the(input: 'Aあ', shouldPass: true);
        the(input: 'Aあア', shouldPass: true);
        the(input: '２あア', shouldPass: false);
        the(input: 'お腹A', shouldPass: false);
        the(input: 'お腹', shouldPass: false);
        the(input: '腹', shouldPass: false);
        the(input: 'A', shouldPass: false);
        the(input: 'あ', shouldPass: false);
        the(input: 'ア', shouldPass: false);
      });
    });
  });
}
