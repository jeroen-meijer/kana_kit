library kana_kit;

import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:kana_kit/kana_kit.dart';
import 'package:kana_kit/src/constants.dart';
import 'package:kana_kit/src/extensions.dart';
import 'package:meta/meta.dart';

export 'src/models/models.dart';

part 'src/conversions.dart';
part 'src/utils.dart';

/// {@template kana_kit}
/// A Dart library for handling and converting Japanese characters such as
/// hiragana, katakana and kanji.
///
/// It contains many methods to deal with Japanese character.
/// In some of these functions, a [KanaKitConfig] is used.
///
/// If [config] is left `null`, [KanaKitConfig.defaultConfig] is used.
///
/// ```dart
/// const kanaKit = KanaKit();
/// ```
///
/// Every `KanaKit` instance has a [copyWithConfig] method that allows you to
/// copy the instance and override `config` fields.
/// {@endtemplate}
class KanaKit {
  /// {@macro kana_kit}
  const KanaKit({
    KanaKitConfig config,
  }) : config = config ?? KanaKitConfig.defaultConfig;

  /// The config used in certain conversions.
  ///
  /// See [KanaKitConfig].
  final KanaKitConfig config;

  /// Tests if [input] consists entirely of romaji characters.
  /// 
  /// ```dart
  /// isRomaji('Tōkyō and Ōsaka'); // true
  /// isRomaji('12a*b&c-d'); // true
  /// isRomaji('あアA'); // false
  /// isRomaji('お願い'); // false
  /// isRomaji('a！b&cーd') // false (zenkaku punctuation is not allowed)
  /// ```
  bool isRomaji(String input) {
    assert(input != null);

    return input.chars.every(_isCharRomaji);
  }

  /// Tests if [input] consists entirely of Japanese characters.
  /// 
  /// ```dart
  /// isJapanese('泣き虫'); // true
  /// isJapanese('あア'); // true
  /// isJapanese('２月') // true (zenkaku numbers are allowed)
  /// isJapanese('泣き虫。！〜＄') // true (zenkaku/JA punctuation is allowed)
  /// isJapanese('泣き虫.!~$') // false (latin punctuation is not allowed)
  /// isJapanese('A泣き虫'); // false
  /// ```
  bool isJapanese(String input) {
    assert(input != null);

    return input.chars.every(_isCharJapanese);
  }

  /// Tests if [input] consists entirely of kana characters.
  /// 
  /// ```dart
  /// isKana('あ'); // true
  /// isKana('ア'); // true
  /// isKana('あーア'); // true
  /// isKana('A'); // false
  /// isKana('あAア'); // false
  /// ```
  bool isKana(String input) {
    assert(input != null);

    return input.chars.every(_isCharKana);
  }

  /// Tests if [input] consists entirely of hiragana characters.
  /// 
  /// ```dart
  /// isHiragana('げーむ'); // true
  /// isHiragana('A'); // false
  /// isHiragana('あア'); // false
  /// ```
  bool isHiragana(String input) {
    assert(input != null);

    return input.chars.every(_isCharHiragana);
  }

  /// Tests if [input] consists entirely of katakana characters.
  /// 
  /// ```dart
  /// isKatakana('ゲーム'); // true
  /// isKatakana('あ'); // false
  /// isKatakana('A'); // false
  /// isKatakana('あア'); // false
  /// ```
  bool isKatakana(String input) {
    assert(input != null);

    return input.chars.every(_isCharKatakana);
  }

  /// Tests if [input] consists entirely of kanji characters.
  ///
  /// ```dart
  /// isKanji('刀'); // true
  /// isKanji('切腹'); // true
  /// isKanji('勢い'); // false
  /// isKanji('あAア'); // false
  /// isKanji('🐸'); // false
  /// ```
  bool isKanji(String input) {
    assert(input != null);

    return input.chars.every(_isCharKanji);
  }

  /// Tests if [input] contains a mix of romaji and kana.
  ///
  /// If this [config]'s [KanaKitConfig.passKanji] is `true`, kanji will be
  /// ignored.
  ///
  /// ```dart
  /// isMixed('Abあア'); // true
  /// isMixed('お腹A') // With KanaKitConfig.passKanji == true: true
  /// isMixed('お腹A') // With KanaKitConfig.passKanji == false: false
  /// isMixed('お腹A'); // false
  /// isMixed('ab'); // false
  /// isMixed('あア'); // false
  /// ```
  bool isMixed(String input) {
    assert(input != null);

    final chars = input.chars;

    final hasRomaji = chars.any(_isCharRomaji);
    final hasKana = chars.any(_isCharHiragana) || chars.any(_isCharKatakana);
    final hasKanji = config.passKanji || chars.any(_isCharKanji);

    return hasKana && hasRomaji && hasKanji;
  }

  /// Converts all kana characters of the [input] to romaji.
  ///
  /// ```dart
  /// toRomaji('ひらがな　カタカナ'); // "hiragana katakana"
  /// toRomaji('げーむ　ゲーム'); // "ge-mu geemu"
  /// ```
  String toRomaji(String input) {
    final hiragana = _katakanaToHiragana(
      input,
      toRomaji: toRomaji,
    );
    final romajiTokens =
        _MappingParser(config.romanization.kanaToRomajiMap).apply(hiragana);

    return romajiTokens.map((romajiToken) {
      final start = romajiToken.start;
      final end = romajiToken.start;
      final romaji = romajiToken.value;

      final makeUpperCase =
          config.upcaseKatakana && isKatakana(input.substring(start, end));

      if (makeUpperCase) {
        return romaji.toUpperCase();
      }
      return romaji;
    }).join();
  }

  /// Converts all characters of the [input] from romaji to kana.
  ///
  /// Lowercase text will result in hiragana and uppercase text will result in
  /// katakana.
  ///
  /// ```dart
  /// toKana('onaji BUTTSUUJI'); // "おなじ ブッツウジ"
  /// toKana('ONAJI buttsuuji'); // "オナジ ぶっつうじ"
  /// toKana('座禅‘zazen’スタイル'); // "座禅「ざぜん」スタイル"
  /// toKana('batsuge-mu'); // "ばつげーむ"
  /// toKana('!?.:/,~-‘’“”[](){}'); // "！？。：・、〜ー「」『』［］（）｛｝"
  /// ```
  String toKana(String input) {}

  /// Converts all characters of the [input] to hiragana.
  String toHiragana(String input) {
    assert(input != null);

    final convertedToKatakana = _katakanaToHiragana(input, toRomaji: toRomaji);

    if (config.passRomaji) {
      return convertedToKatakana;
    }

    if (copyWithConfig(passRomaji: true).isMixed(input)) {
      return toKana(convertedToKatakana.toLowerCase());
    }

    if (isRomaji(input) || _isCharEnglishPunctuation(input)) {
      return toKana(input.toLowerCase());
    }

    return convertedToKatakana;
  }

  /*
  // Conversion
  toKatakana

  // Other utils
  stripOkurigana
  */

  /// Creates a copy of this object that replaces the provided [KanaKitConfig]
  /// fields.
  KanaKit copyWithConfig({
    bool passRomaji,
    bool passKanji,
    bool upcaseKatakana,
    Romanization romanization,
  }) {
    return KanaKit(
      config: KanaKitConfig(
        passRomaji: passRomaji ?? config.passRomaji,
        passKanji: passKanji ?? config.passKanji,
        upcaseKatakana: upcaseKatakana ?? config.upcaseKatakana,
        romanization: romanization ?? config.romanization,
      ),
    );
  }
}
