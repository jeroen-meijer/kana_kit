import 'package:kana_kit/src/utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tuple', () {
    const left = 20.7;
    const right = 'Frederik';

    test('props are correct', () {
      // ignore: prefer_const_constructors
      final actual = Tuple(left, right).props;
      const expected = [left, right];

      expect(actual, expected);
    });
    test('.toString is correct', () {
      expect(
        const Tuple(left, right).toString(),
        'Tuple<double, String>(20.7, Frederik)',
      );
    });

    test('left is correct', () {
      expect(const Tuple(left, right).left, left);
    });
    test('right is correct', () {
      expect(const Tuple(left, right).right, right);
    });
  });
  group('Tuple Extensions', () {
    const tuples = [
      Tuple(1, 'a'),
      Tuple(2, 'b'),
      Tuple(3, 'c'),
    ];

    test('allLefts returns all left elements', () {
      expect(tuples.allLefts, [1, 2, 3]);
    });
    test('allRights returns all right elements', () {
      expect(tuples.allRights, ['a', 'b', 'c']);
    });
  });
  group('String Extensions', () {
    test('chars returns characters', () {
      expect('abcdefg'.chars, ['a', 'b', 'c', 'd', 'e', 'f', 'g']);
    });
    test('reversed returns reversed string', () {
      expect('abcdefg'.reversed, 'gfedcba');
    });
    test('code returns first code unit', () {
      expect('abcdefg'.code, 'a'.codeUnitAt(0));
    });
    test('isUpperCase returns true if string is uppercase', () {
      expect('abcdefg'.isUpperCase, isFalse);
      expect('ABCDEFG'.isUpperCase, isTrue);
    });
    test('isLowerCase returns true if string is lowercase', () {
      expect('abcdefg'.isLowerCase, isTrue);
      expect('ABCDEFG'.isLowerCase, isFalse);
    });
    group('containsAny', () {
      test('return false if no candidates are provided', () {
        expect('I love Tokyo'.containsAny([]), isFalse);
      });
      test('returns true if string contains any of the candidates', () {
        expect('I love Tokyo'.containsAny(['Tokyo', 'Kyoto']), isTrue);
      });
      test('returns false if string does not contain any of the candidates',
          () {
        expect('I love Osaka'.containsAny(['Tokyo', 'Kyoto']), isFalse);
      });
    });
  });
}
