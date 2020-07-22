/// Formats a `String` to better represent its underlying value.
String formatInput(String input) {
  if (input == null) {
    return '$input';
  } else if (input.isEmpty) {
    return 'an empty string';
  } else {
    return '"$input"';
  }
}
