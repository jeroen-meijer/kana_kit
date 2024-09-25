import 'package:checks/checks.dart';
import 'package:kana_kit/src/utils.dart';
import 'package:test/test.dart';

void main() {
  group('TupleRecordIterableExtensions', () {
    const tuples = [
      (1, 'a'),
      (2, 'b'),
      (3, 'c'),
    ];

    test('allLefts returns first of every element', () {
      check(tuples.allLefts).deepEquals([1, 2, 3]);
    });
    test('allRights returns first of every element', () {
      check(tuples.allRights).deepEquals(['a', 'b', 'c']);
    });
  });

  group('String Extensions', () {
    test('chars returns characters', () {
      check('abcdefg'.chars).deepEquals(['a', 'b', 'c', 'd', 'e', 'f', 'g']);
    });

    test('reversed returns reversed string', () {
      // cspell: disable
      check('abcdefg'.reversed).equals('gfedcba');
      // cspell: enable
    });

    test('code returns first code unit', () {
      check('a'.code).equals('a'.codeUnitAt(0));
    });

    test('isUpperCase returns true if string is uppercase', () {
      check('abcdefg'.isUpperCase).isFalse();
      check('ABCDEFG'.isUpperCase).isTrue();
    });

    test('isLowerCase returns true if string is lowercase', () {
      check('abcdefg'.isLowerCase).isTrue();
      check('ABCDEFG'.isLowerCase).isFalse();
    });

    group('containsAny', () {
      test('return false if no candidates are provided', () {
        check('I love Tokyo'.containsAny([])).isFalse();
      });

      test('returns true if string contains any of the candidates', () {
        check('I love Tokyo'.containsAny(['Tokyo', 'Kyoto'])).isTrue();
      });

      test(
        'returns false if string does not contain any of the candidates',
        () {
          check('I love Osaka'.containsAny(['Tokyo', 'Kyoto'])).isFalse();
        },
      );
    });
  });
}
