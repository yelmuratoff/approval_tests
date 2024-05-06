part of '../../approval_dart.dart';

/// `Options` class is a class that contains two variables `isScrub` and `fileExtensionWithoutDot`. Used to set options for the approval test.
class Options {
  // A final bool variable `isScrub`. Its default value is set as false.
  final bool isScrub;

  // A final String variable `fileExtensionWithoutDot`. Its default value is set as 'txt'.
  final String fileExtensionWithoutDot;

  final Comparator comparator;

  // A constructor for the class Options which initializes `isScrub` and `fileExtensionWithoutDot`.
  const Options({
    this.isScrub = false,
    this.fileExtensionWithoutDot = 'txt',
    this.comparator = const CommandLineComparator(),
  });

  // A method named `scrub` takes a string input, if `isScrub` is true it scrubs the input,
  // otherwise returns it as is.
  String scrub(String input) => isScrub ? _scrubInput(input) : input;

  // A private method named `_scrubInput` that takes a string as input, removes all extra whitespaces
  // from the string and trims it (removes leading and trailing spaces).
  String _scrubInput(String input) {
    return input.replaceAll(RegExp(r'\s+'), ' ').trim();
  }
}
