part of '../kana_kit.dart';

String _katakanaToHiragana(
  String input, {
  @required String Function(String) toRomaji,
  bool isDestinationRomaji = false,
}) {
  bool isCharInitialLongDash(String char, int index) {
    assert(char.length == 1);

    return _isCharLongDash(char) && index == 0;
  }

  bool isCharInnerLongDash(String char, int index) {
    assert(char.length == 1);

    return _isCharLongDash(char) && index > 0;
  }

  bool isKanaAsSymbol(String char) {
    assert(char.length == 1);

    return ['ヶ', 'ヵ'].contains(char);
  }

  const longVowels = {
    'a': 'あ',
    'i': 'い',
    'u': 'う',
    'e': 'え',
    'o': 'う',
  };

  var previousKana = '';

  return input.chars.reduceWithIndex((hira, char, index) {
    // Short circuit to avoid incorrect codeshift for 'ー' and '・'.
    if (_isCharSlashDot(char) ||
        isCharInitialLongDash(char, index) ||
        isKanaAsSymbol(char)) {
      return '$hira$char';
      // Transform long vowels: 'オー' to 'おう'.
    } else if (previousKana.isNotEmpty && isCharInnerLongDash(char, index)) {
      // Transform previousKana back to romaji, and slice off the vowel.
      final romaji = toRomaji(previousKana).chars.last;
      // However, ensure 'オー' => 'おお' => 'oo' if this is a transform on the
      // way to romaji.
      if (_isCharKatakana(input[index - 1]) &&
          romaji == 'o' &&
          isDestinationRomaji) {
        return '$hiraお';
      }
      return '$hira${longVowels[romaji]}';
    } else if (!_isCharLongDash(char) && _isCharKatakana(char)) {
      // Shift charcode.
      final code = char.code + (hiraganaStart - katakanaStart);
      final hiraChar = String.fromCharCode(code);
      previousKana = hiraChar;
      return '$hira$hiraChar';
    }

    // Pass non-katakana chars through.
    previousKana = '';
    return '$hira$char';
  });
}

String _hiraganaToKatakana(String input) {
  final kata = StringBuffer();

  final chars = input.chars;
  for (final char in chars) {
    if (_isCharLongDash(char) || _isCharSlashDot(char)) {
      kata.write(char);
    } else if (_isCharHiragana(char)) {
      final code = char.code + (katakanaStart - hiraganaStart);
      final kataChar = String.fromCharCode(code);
      kata.write(kataChar);
    } else {
      kata.write(char);
    }
  }

  return kata.toString();
}

class _CharacterConversionToken extends Equatable {
  const _CharacterConversionToken(
    this.start,
    this.end,
    this.value,
  )   : assert(start != null),
        assert(end != null),
        assert(value != null);

  final int start;
  final int end;
  final String value;

  @override
  List<Object> get props => [
        start,
        end,
        value,
      ];
}

/// Internal helper class that can take the [root] mapping and apply it to the
/// given `input` [String].
///
/// In other words, it takes a [Map<String, dynamic>] from [Romanization] and
/// can convert a [String] from kana to romaji and vice versa.
class _MappingParser {
  const _MappingParser(this.root);

  final Map<String, dynamic> root;

  /// Applies this
  List<_CharacterConversionToken> apply(String input) {
    return _newChunk(input, 0);
  }

  Map<String, dynamic> _nextSubtree(
    Map<String, dynamic> tree,
    String nextChar,
  ) {
    final subtree = tree[nextChar];
    if (subtree == null) {
      return null;
    }
    // If the next child node does not have a node value, set its node value to
    // the input.
    return {'': tree[''] + nextChar, ...tree[nextChar]};
  }

  List<_CharacterConversionToken> _newChunk(
    String remaining,
    int currentCursor,
  ) {
    // start parsing a new chunk
    final firstChar = remaining.chars.first;

    return _parse(
      tree: {'': firstChar, ...root[firstChar]},
      remaining: remaining.substring(1),
      lastCursor: currentCursor,
      currentCursor: currentCursor + 1,
    );
  }

  List<_CharacterConversionToken> _parse({
    Map<String, dynamic> tree,
    String remaining,
    int lastCursor,
    int currentCursor,
  }) {
    final element = tree[''] as String;

    if (remaining.isEmpty) {
      // nothing more to consume, just commit the last chunk and return it
      // so as to not have an empty element at the end of the result

      return [
        if (element != null)
          _CharacterConversionToken(lastCursor, currentCursor, element),
      ];
    }

    if (tree.keys.length == 1) {
      return [
        _CharacterConversionToken(lastCursor, currentCursor, element),
        ..._newChunk(remaining, currentCursor),
      ];
    }

    final subtree = _nextSubtree(tree, remaining.chars.first);
    if (subtree == null) {
      return [
        _CharacterConversionToken(lastCursor, currentCursor, element),
        ..._newChunk(remaining, currentCursor),
      ];
    }

    // Continue parsing current branch.
    return _parse(
      tree: subtree,
      remaining: remaining.substring(1),
      lastCursor: lastCursor,
      currentCursor: currentCursor + 1,
    );
  }
}
