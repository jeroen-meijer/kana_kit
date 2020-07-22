// ignore_for_file: public_member_api_docs
class Tuple<T1, T2> {
  const Tuple(this.left, this.right);

  final T1 left;
  final T2 right;
}

extension TupleListUtils<T1, T2> on List<Tuple<T1, T2>> {
  List<T1> get allLefts => map((t) => t.left).toList();
  List<T2> get allRights => map((t) => t.right).toList();
}

extension IterableUtils<T> on Iterable<T> {
  /// Runs [reduce] but adds the current index.
  T reduceWithIndex(T Function(T acc, T cur, int idx) combine) {
    var idx = 0;
    return reduce((acc, cur) {
      idx++;
      return combine(acc, cur, idx);
    });
  }
}

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
