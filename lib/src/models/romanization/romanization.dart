import 'package:equatable/equatable.dart';

part 'hepburn.dart';

/// A class containing maps that indicates how to convert between kana
/// characters and romaji.
///
/// Currently only supports [hepburn]
/// (https://en.wikipedia.org/wiki/Hepburn_romanization).
class Romanization extends Equatable {
  const Romanization._({
    required this.name,
    required this.kanaToRomajiMap,
    required this.romajiToKanaMap,
  });

  /// The name of this Romanization.
  final String name;

  /// The map that can be used to convert from kana to romaji.
  final Map<String, dynamic> kanaToRomajiMap;

  /// The map that can be used to convert from romaji to kana.
  final Map<String, dynamic> romajiToKanaMap;

  /// The Hepburn romanization map. (https://en.wikipedia.org/wiki/Hepburn_romanization)
  static const hepburn = _hepburn;

  /// Indicates if this is [Romanization.hepburn].
  bool get isHepburn => this == hepburn;

  @override
  String toString() => '$Romanization ($name)';

  @override
  List<Object> get props => [name];
}
