import 'package:equatable/equatable.dart';

import 'package:kana_kit/kana_kit.dart';

/// {@template kana_kit_config}
/// A configuration class with flags that influence
/// certain parts of KanaKit.
///
/// To use a default config and customize it, use [defaultConfig] and replace
/// fields using [copyWith].
/// {@endtemplate}
class KanaKitConfig extends Equatable {
  /// {@macro kana_kit_config}
  const KanaKitConfig({
    required this.passRomaji,
    required this.passKanji,
    required this.upcaseKatakana,
    this.romanization = Romanization.hepburn,
  });

  /// The default config for `KanaKit`.
  ///
  /// ```dart
  /// KanaKitConfig(
  ///   passRomaji: false,
  ///   passKanji: true,
  ///   upcaseKatakana: false,
  ///   romanization: Romanization.hepburn,
  /// )
  /// ```
  static const defaultConfig = KanaKitConfig(
    passRomaji: false,
    passKanji: true,
    upcaseKatakana: false,
  );

  /// Indicates whether to skip romaji characters when converting text using
  /// [KanaKit.toKatakana] or [KanaKit.toHiragana].
  ///
  ///
  /// ```dart
  /// passRomaji: true
  /// ```
  final bool passRomaji;

  /// Indicates whether to ignore kanji when checking [KanaKit.isMixed].
  ///
  ///
  /// ```dart
  /// passKanji: false
  /// ```
  final bool passKanji;

  /// Indicates whether to convert katakana to uppercase using
  /// [KanaKit.toRomaji].
  ///
  ///
  /// ```dart
  /// upcaseKatakana: true
  /// ```
  final bool upcaseKatakana;

  /// The romanization map used for converting to and from Japanese and Latin
  /// characters.
  ///
  /// ```dart
  /// romanization: Romanizaion.hepburn,
  /// ```
  final Romanization romanization;

  /// Creates a copy of this object that replaces the provided fields.
  KanaKitConfig copyWith({
    bool? passRomaji,
    bool? passKanji,
    bool? upcaseKatakana,
  }) {
    return KanaKitConfig(
      passRomaji: passRomaji ?? this.passRomaji,
      passKanji: passKanji ?? this.passKanji,
      upcaseKatakana: upcaseKatakana ?? this.upcaseKatakana,
    );
  }

  @override
  List<Object> get props => [
        passRomaji,
        passKanji,
        upcaseKatakana,
        romanization,
      ];
}
