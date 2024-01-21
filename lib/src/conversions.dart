part of '../kana_kit.dart';

/// Internal function that converts an a katakana [input] to hiragana.
String _katakanaToHiragana(
  String input, {
  required String Function(String) toRomaji,
  bool destinationIsRomaji = false,
}) {
  bool isCharInitialLongDash(String char, int index) {
    assert(char.length == 1, _charSingleDigitWarning);
    return _isCharLongDash(char) && index == 0;
  }

  bool isCharInnerLongDash(String char, int index) {
    assert(char.length == 1, _charSingleDigitWarning);
    return _isCharLongDash(char) && index > 0;
  }

  bool isKanaAsSymbol(String char) {
    assert(char.length == 1, _charSingleDigitWarning);
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

  final chars = input.chars;
  final hiraChars = <String>[];
  for (var index = 0; index < chars.length; index++) {
    final char = chars[index];
    // Short circuit to avoid incorrect codeshift for 'ー' and '・'.
    if (_isCharSlashDot(char) ||
        isCharInitialLongDash(char, index) ||
        isKanaAsSymbol(char)) {
      hiraChars.add(char);
      continue;
      // Transform long vowels: 'オー' to 'おう'.
    } else if (previousKana.isNotEmpty && isCharInnerLongDash(char, index)) {
      // Transform previousKana back to romaji, and slice off the vowel.
      final romaji = toRomaji(previousKana).chars.last;
      // However, ensure 'オー' => 'おお' => 'oo' if this is a transform on the
      // way to romaji.
      if (_isCharKatakana(input[index - 1]) &&
          romaji == 'o' &&
          destinationIsRomaji) {
        hiraChars.add('お');
        continue;
      }
      hiraChars.add(longVowels[romaji]!);
      continue;
    } else if (!_isCharLongDash(char) && _isCharKatakana(char)) {
      // Shift charcode.
      final code = char.code + (hiraganaStart - katakanaStart);
      final hiraChar = String.fromCharCode(code);
      previousKana = hiraChar;
      hiraChars.add(hiraChar);
      continue;
    }

    // Pass non-katakana chars through.
    previousKana = '';
    hiraChars.add(char);
  }

  return hiraChars.join();
}

/// Internal function that converts an a hiragana [input] to katakana.
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

/// An internal data class that represents the conversion of one or more
/// characters from a `String` to a new [value] after calling
/// [_MappingParser.apply] on a character map (such as
/// [Romanization.kanaToRomajiMap]).
class _CharacterConversionToken {
  const _CharacterConversionToken(
    this.start,
    this.end,
    this.value,
  );

  /// The starting index of the character from the original `String` that has
  /// been mapped to [value].
  final int start;

  /// The last index of the character from the original `String` that has
  /// been mapped to [value].
  final int end;

  /// The result of mapping the original `String` from [start] to [end].
  final String value;
}

/// Internal helper class that can take the [root] mapping and apply it to the
/// given `input` `String`.
///
/// In other words, it takes a [Map<String, dynamic>] from [Romanization] and
/// can convert a `String` from kana to romaji and vice versa.
class _MappingParser {
  const _MappingParser(this.root);

  final Map<String, dynamic> root;

  /// Applies the [root] to the [input].
  ///
  /// In other words, converts the [input] using the [root] mapping.
  List<_CharacterConversionToken> apply(String input) {
    return _newChunk(input, 0);
  }

  Map<String, dynamic>? _nextSubtree(
    Map<String, dynamic> tree,
    String nextChar,
  ) {
    final subtree = tree[nextChar];

    if (subtree == null) {
      return null;
    }
    // If the next child node does not have a node value, set its node value to
    // the input.
    final rootNode = tree[''] as String? ?? '';
    final updatedRootNode = rootNode + nextChar;
    final nextSubtree = tree[nextChar] as Map<String, dynamic>?;
    return {'': updatedRootNode, ...nextSubtree ?? {}};
  }

  List<_CharacterConversionToken> _newChunk(
    String remaining,
    int currentCursor,
  ) {
    // Start parsing a new chunk.
    final firstChar = remaining.chars.first;
    final firstCharNode = root[firstChar] as Map<String, dynamic>?;
    return _parse(
      tree: {'': firstChar, ...firstCharNode ?? {}},
      remaining: remaining.substring(1),
      lastCursor: currentCursor,
      currentCursor: currentCursor + 1,
    );
  }

  List<_CharacterConversionToken> _parse({
    required Map<String, dynamic> tree,
    required String remaining,
    required int lastCursor,
    required int currentCursor,
  }) {
    final element = tree[''] as String?;

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
        _CharacterConversionToken(lastCursor, currentCursor, element!),
        ..._newChunk(remaining, currentCursor),
      ];
    }

    final subtree = _nextSubtree(tree, remaining.chars.first);
    if (subtree == null) {
      return [
        _CharacterConversionToken(lastCursor, currentCursor, element!),
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
