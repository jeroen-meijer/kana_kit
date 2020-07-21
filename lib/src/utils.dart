part of '../kana_kit.dart';

bool _isCharInRange(
  String char, {
  @required int start,
  @required int end,
}) {
  assert(char.length == 1);

  final code = char.code;
  return start <= code && code <= end;
}

bool _isCharHiragana(String char) {
  assert(char.length == 1);

  return _isCharInRange(
    char,
    start: hiraganaStart,
    end: hiraganaEnd,
  );
}

bool _isCharKatakana(String char) {
  assert(char.length == 1);

  return _isCharInRange(
    char,
    start: katakanaStart,
    end: katakanaEnd,
  );
}

bool _isCharKanji(String char) {
  assert(char.length == 1);

  return _isCharInRange(
    char,
    start: kanjiStart,
    end: kanjiEnd,
  );
}

bool _isCharUpperCase(String char) {
  assert(char.length == 1);

  return char.isUpperCase ||
      _isCharInRange(
        char,
        start: latinUppercaseStart,
        end: latinUppercaseEnd,
      );
}

bool _isCharLowerCase(String char) {
  assert(char.length == 1);

  return char.isLowerCase ||
      _isCharInRange(
        char,
        start: latinLowercaseStart,
        end: latinLowercaseEnd,
      );
}

bool _isCharKana(String char) {
  assert(char.length == 1);

  return _isCharHiragana(char) || _isCharKatakana(char);
}

bool _isCharLongDash(String char) {
  assert(char.length == 1);

  return char.code == prolongedSoundMark;
}

bool _isCharSlashDot(String char) {
  assert(char.length == 1);

  return char.code == kanaSlashDot;
}

bool _isCharRomaji(String char) {
  assert(char.length == 1);

  return romajiRanges.any((range) {
    return _isCharInRange(char, start: range.left, end: range.right);
  });
}

bool _isCharEnglishPunctuation(String char) {
  assert(char.length == 1);

  return enPunctuationRanges.any((range) {
    return _isCharInRange(char, start: range.left, end: range.right);
  });
}

bool _isCharJapanesePunctuation(String char) {
  assert(char.length == 1);

  return jaPunctuationRanges.any((range) {
    return _isCharInRange(char, start: range.left, end: range.right);
  });
}

bool _isCharJapanese(String char) {
  assert(char.length == 1);

  return japaneseRanges.any((range) {
    return _isCharInRange(char, start: range.left, end: range.right);
  });
}

bool _isCharPunctuation(String char) {
  assert(char.length == 1);

  return _isCharEnglishPunctuation(char) || _isCharJapanesePunctuation(char);
}

bool _isCharConsonant(String char, {bool includeY = true}) {
  assert(char.length == 1);
  assert(includeY != null);

  final consonants = [
    ...'bcdfghjklmnpqrstvwxz'.chars,
    if (includeY) 'y',
  ];

  return char.toLowerCase().containsAny(consonants);
}

bool _isCharVowel(String char, {bool includeY = true}) {
  assert(char.length == 1);
  assert(includeY != null);

  final vowels = [
    ...'aeiou'.chars,
    if (includeY) 'y',
  ];

  return char.toLowerCase().containsAny(vowels);
}
