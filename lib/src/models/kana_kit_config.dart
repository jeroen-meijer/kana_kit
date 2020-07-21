import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

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
    @required this.useObsoleteKana,
    @required this.passRomaji,
    @required this.upcaseKatakana,
    @required this.customKanaMapping,
    @required this.customRomajiMapping,
    @required this.imeMode,
    @required this.romanization,
  })  : assert(useObsoleteKana != null),
        assert(passRomaji != null),
        assert(upcaseKatakana != null),
        assert(customKanaMapping != null),
        assert(imeMode != null),
        assert(romanization != null);

  /// The default config for `KanaKit`.
  ///
  /// ```dart
  /// KanaKitConfig(
  ///   useObsoleteKana: false,
  ///   passRomaji: false,
  ///   upcaseKatakana: false,
  ///   customKanaMapping: {},
  ///   customRomajiMapping: {},
  ///   imeMode: ImeMode.disabled,
  ///   romanization: Romanization.hepburn,
  /// )
  /// ```
  static const defaultConfig = KanaKitConfig(
    useObsoleteKana: false,
    passRomaji: false,
    upcaseKatakana: false,
    customKanaMapping: {},
    customRomajiMapping: {},
    imeMode: ImeMode.disabled,
    romanization: Romanization.hepburn,
  );

  /// Indicates whether to use obsolete characters, such as ゐ and ゑ.
  ///
  ///
  /// ```dart
  /// useObsoleteKana: true
  /// ```
  final bool useObsoleteKana;

  /// Indicates whether to pass romaji when using mixed syllabaries with
  /// `toKatakana()` or `toHiragana()`.
  ///
  ///
  /// ```dart
  /// passRomaji: true
  /// ```
  final bool passRomaji;

  /// Indicates whether to convert katakana to uppercase using `toRomaji()`.
  ///
  ///
  /// ```dart
  /// upcaseKatakana: true
  /// ```
  final bool upcaseKatakana;

  /// The [ImeMode] to use for certain conversions.
  ///
  ///
  /// ```dart
  /// imeMode: ImeMode.toHiragana
  /// ```
  final ImeMode imeMode;

  /// A custom map that maps single romaji characters to something else
  /// (usually a kana character).
  ///
  ///
  /// ```dart
  ///  customKanaMapping: {
  ///    'na': 'に',
  ///    'ka': 'nana',
  ///  }
  /// ```
  final Map<String, String> customKanaMapping;

  /// A custom map that maps single kana characters to something else
  /// (usually one or more romaji characters).
  ///
  /// ```dart
  ///  customRomajiMapping: {
  ///    'じ': 'zi',
  ///    'つ': 'tu',
  ///    'り': 'li',
  ///  }
  /// ```
  final Map<String, String> customRomajiMapping;

  /// The romanization map used for romanizing kana characters.
  ///
  /// ```dart
  /// romanization: Romanizaion.hepburn,
  /// ```
  final Romanization romanization;

  /// Creates a copy of this object that replaces the provided fields.
  KanaKitConfig copyWith({
    bool useObsoleteKana,
    bool passRomaji,
    bool upcaseKatakana,
    ImeMode imeMode,
    Map<String, String> customKanaMapping,
    Map<String, String> customRomajiMapping,
    Romanization romanization,
  }) {
    return KanaKitConfig(
      useObsoleteKana: useObsoleteKana ?? this.useObsoleteKana,
      passRomaji: passRomaji ?? this.passRomaji,
      upcaseKatakana: upcaseKatakana ?? this.upcaseKatakana,
      imeMode: imeMode ?? this.imeMode,
      customKanaMapping: customKanaMapping ?? this.customKanaMapping,
      customRomajiMapping: customRomajiMapping ?? this.customRomajiMapping,
      romanization: romanization ?? this.romanization,
    );
  }

  @override
  List<Object> get props => [
        useObsoleteKana,
        passRomaji,
        upcaseKatakana,
        customKanaMapping,
        customRomajiMapping,
        imeMode,
        romanization,
      ];
}
