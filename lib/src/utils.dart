import 'package:equatable/equatable.dart';

/// {@template tuple}
/// A data class that contains two elements ([left] and [right]).
/// {@endtemplate}
class Tuple<T1, T2> extends Equatable {
  /// {@macro tuple}
  const Tuple(this.left, this.right);

  /// The first element.
  final T1 left;

  /// The second element.
  final T2 right;

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [left, right];
}

/// Extensions that make handling collections of [Tuple]s more convenient.
extension TupleIterableUtils<T1, T2> on Iterable<Tuple<T1, T2>> {
  /// Returns a new [Iterator<T1>] that contains all `left` elements.
  Iterable<T1> get allLefts => map((t) => t.left);

  /// Returns a new [Iterator<T2>] that contains all `right` elements.
  Iterable<T2> get allRights => map((t) => t.right);
}

/// Extensions that make handling [String]s more convenient.
extension StringUtils on String {
  /// Returns a list of every character in this `String`.
  List<String> get chars => split('');

  /// Returns the reverse of this string.
  ///
  /// ```dart
  /// "Hello".reversed; // "olleH"
  /// ```
  String get reversed => chars.reversed.join();

  /// The code unit for the first character in this `String`.
  ///
  /// Shorthand for [codeUnitAt(0)].
  int get code {
    return codeUnitAt(0);
  }

  /// Indicates if this entire `String` only contains uppercase letters.
  bool get isUpperCase {
    return this == toUpperCase();
  }

  /// Indicates if this entire `String` only contains lowercase letters.
  bool get isLowerCase {
    return this == toLowerCase();
  }

  /// Returns `true` if this string contains any of the [candidates].
  bool containsAny(Iterable<String> candidates) {
    if (candidates.isEmpty) {
      return false;
    }

    return contains(candidates.first) || containsAny(candidates.skip(1));
  }
}
