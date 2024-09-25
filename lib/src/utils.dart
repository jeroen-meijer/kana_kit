import 'dart:core';

/// Extensions that make handling collections of tuple records more convenient.
extension TupleRecordIterableExtensions<T1, T2> on Iterable<(T1, T2)> {
  /// Returns a new [Iterator<T1>] that contains all `left` elements.
  Iterable<T1> get allLefts => map((t) => t.$1);

  /// Returns a new [Iterator<T2>] that contains all `right` elements.
  Iterable<T2> get allRights => map((t) => t.$2);
}

/// Extensions that make handling [String]s more convenient.
extension StringExtensions on String {
  /// Returns a list of every character in this `String`.
  List<String> get chars => split('');

  /// Returns the reverse of this string.
  ///
  // cspell: disable
  /// ```dart
  /// "Hello".reversed; // "olleH"
  /// ```
  // cspell: enable
  String get reversed => chars.reversed.join();

  /// The code unit for the first character in this `String`.
  ///
  /// Shorthand for [codeUnitAt(0)].
  int get code {
    assert(length == 1, 'String must be exactly one character long.');
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
