// ignore_for_file: public_member_api_docs
// ignore_for_file: type_annotate_public_apis

// Character codes
const latinLowercaseStart = 0x61;
const latinLowercaseEnd = 0x7a;
const latinUppercaseStart = 0x41;
const latinUppercaseEnd = 0x5a;
const lowercaseZenkakuStart = 0xff41;
const lowercaseZenkakuEnd = 0xff5a;
const uppercaseZenkakuStart = 0xff21;
const uppercaseZenkakuEnd = 0xff3a;
const hiraganaStart = 0x3041;
const hiraganaEnd = 0x3096;
const katakanaStart = 0x30a1;
const katakanaEnd = 0x30fc;
const kanjiStart = 0x4e00;
const kanjiEnd = 0x9faf;
const prolongedSoundMark = 0x30fc;
const kanaSlashDot = 0x30fb;

const kanaRanges = [
  _hiraganaChars,
  _katakanaChars,
  _kanaPunctuation,
  _hankakuKatakana,
];

const jaPunctuationRanges = [
  _cjkSymbolsPunctuation,
  _kanaPunctuation,
  _katakanaPunctuation,
  _zenkakuPunctuation_1,
  _zenkakuPunctuation_2,
  _zenkakuPunctuation_3,
  _zenkakuPunctuation_4,
  _zenkakuSymbolsCurrency,
];

// All Japanese unicode start and end ranges.
// Includes kanji, kana, zenkaku Latin chars, punctuations and number ranges.
final japaneseRanges = [
  ...kanaRanges,
  ...jaPunctuationRanges,
  _zenkakuUppercase,
  _zenkakuLowercase,
  _zenkakuNumbers,
  _commonCjk,
  _rareCjk,
];

const modernEnglish = (0x0000, 0x007f);
const hepburnMacronRanges = [
  (0x0100, 0x0101), // Ā ā
  (0x0112, 0x0113), // Ē ē
  (0x012a, 0x012b), // Ī ī
  (0x014c, 0x014d), // Ō ō
  (0x016a, 0x016b), // Ū ū
];
const smartQuoteRanges = [
  (0x2018, 0x2019), // ‘ ’
  (0x201c, 0x201d), // “ ”
];

final romajiRanges = [modernEnglish, ...hepburnMacronRanges];

final enPunctuationRanges = [
  const (0x20, 0x2f),
  const (0x3a, 0x3f),
  const (0x5b, 0x60),
  const (0x7b, 0x7e),
  ...smartQuoteRanges,
];

// Private
const _zenkakuNumbers = (0xff10, 0xff19);
const _zenkakuUppercase = (uppercaseZenkakuStart, uppercaseZenkakuEnd);
const _zenkakuLowercase = (lowercaseZenkakuStart, lowercaseZenkakuEnd);
const _zenkakuPunctuation_1 = (0xff01, 0xff0f);
const _zenkakuPunctuation_2 = (0xff1a, 0xff1f);
const _zenkakuPunctuation_3 = (0xff3b, 0xff3f);
const _zenkakuPunctuation_4 = (0xff5b, 0xff60);
const _zenkakuSymbolsCurrency = (0xffe0, 0xffee);

const _hiraganaChars = (0x3040, 0x309f);
const _katakanaChars = (0x30a0, 0x30ff);
const _hankakuKatakana = (0xff66, 0xff9f);
const _katakanaPunctuation = (0x30fb, 0x30fc);
const _kanaPunctuation = (0xff61, 0xff65);
const _cjkSymbolsPunctuation = (0x3000, 0x303f);
const _commonCjk = (0x4e00, 0x9fff);
const _rareCjk = (0x3400, 0x4dbf);
