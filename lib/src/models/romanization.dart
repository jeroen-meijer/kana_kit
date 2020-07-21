import 'package:equatable/equatable.dart';

/// A class containing maps that indicates how to convert between kana
/// characters and romaji.
///
/// Currently only supports [hepburn]
/// (https://en.wikipedia.org/wiki/Hepburn_romanization).
class Romanization extends Equatable {
  const Romanization._(this.name, this._map);

  /// The name of this Romanization.
  final String name;

  /// Internal map used for character conversion.
  final Map<String, String> _map;

  /// The Hepburn romanization map. (https://en.wikipedia.org/wiki/Hepburn_romanization)
  static const hepburn = Romanization._('Hepburn', {});

  /// Indicates if this
  bool get isHepburn => this == hepburn;

  @override
  String toString() => '$Romanization ($name)';

  @override
  List<Object> get props => [name];
}
