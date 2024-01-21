part of '../kana_kit.dart';

const _charSingleDigitWarning = 'char must be a single character';

bool _isCharInRange(
  String char, {
  required int start,
  required int end,
}) {
  assert(char.length == 1, _charSingleDigitWarning);

  final code = char.code;
  return start <= code && code <= end;
}

bool _isCharHiragana(String char) {
  assert(char.length == 1, _charSingleDigitWarning);

  return _isCharLongDash(char) ||
      _isCharInRange(
        char,
        start: hiraganaStart,
        end: hiraganaEnd,
      );
}

bool _isCharKatakana(String char) {
  assert(char.length == 1, _charSingleDigitWarning);

  return _isCharInRange(
    char,
    start: katakanaStart,
    end: katakanaEnd,
  );
}

bool _isCharKanji(String char) {
  assert(char.length == 1, _charSingleDigitWarning);

  return _isCharInRange(
    char,
    start: kanjiStart,
    end: kanjiEnd,
  );
}

bool _isCharUpperCase(String char) {
  assert(char.length == 1, _charSingleDigitWarning);

  return _isCharInRange(
    char,
    start: latinUppercaseStart,
    end: latinUppercaseEnd,
  );
}

bool _isCharKana(String char) {
  assert(char.length == 1, _charSingleDigitWarning);

  return _isCharHiragana(char) || _isCharKatakana(char);
}

bool _isCharLongDash(String char) {
  assert(char.length == 1, _charSingleDigitWarning);

  return char.code == prolongedSoundMark;
}

bool _isCharSlashDot(String char) {
  assert(char.length == 1, _charSingleDigitWarning);

  return char.code == kanaSlashDot;
}

bool _isCharRomaji(String char) {
  assert(char.length == 1, _charSingleDigitWarning);

  return romajiRanges.any((range) {
    return _isCharInRange(char, start: range.left, end: range.right);
  });
}

bool _isCharEnglishPunctuation(String char) {
  assert(char.length == 1, _charSingleDigitWarning);

  return enPunctuationRanges.any((range) {
    return _isCharInRange(char, start: range.left, end: range.right);
  });
}

bool _isCharJapanese(String char) {
  assert(char.length == 1, _charSingleDigitWarning);

  return japaneseRanges.any((range) {
    return _isCharInRange(char, start: range.left, end: range.right);
  });
}
