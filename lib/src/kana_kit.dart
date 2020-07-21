import 'package:kana_kit/kana_kit.dart';

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
/// Every `KanaKit` instance has a [copyWith] method that allows you to copy the
/// instance and provide a new `config`.
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

  /// Creates a copy of this object that replaces the provided fields.
  KanaKit copyWith({
    KanaKitConfig config,
  }) {
    return KanaKit(
      config: config ?? this.config,
    );
  }
}
