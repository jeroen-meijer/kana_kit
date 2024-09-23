part 'hepburn.dart';

/// An enum containing maps that indicates how to convert between kana
/// characters and romaji.
///
/// Currently only supports [hepburn].
/// (https://en.wikipedia.org/wiki/Hepburn_romanization).
enum Romanization {
  /// The Hepburn romanization map. (https://en.wikipedia.org/wiki/Hepburn_romanization)
  hepburn(
    name: 'Hepburn',
    kanaToRomajiMap: _hepburnKanaToRomajiMap,
    romajiToKanaMap: _hepburnRomajiToKanaMap,
  ),
  ;

  const Romanization({
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

  @override
  String toString() => '$Romanization($name)';
}
