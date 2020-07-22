import 'package:kana_kit/kana_kit.dart';
import 'package:test/test.dart';

void main() {
  group('Romanization', () {
    test('props are correct', () {
      final actual = Romanization.hepburn.props;

      final expected = [
        Romanization.hepburn.name,
      ];

      expect(actual, expected);
    });
    group('.is', () {
      test('Hepburn is correct', () {
        expect(Romanization.hepburn.isHepburn, isTrue);
      });
    });

    test('.toString is correct', () {
      expect(
        Romanization.hepburn.toString(),
        'Romanization (Hepburn)',
      );
    });
  });
}
