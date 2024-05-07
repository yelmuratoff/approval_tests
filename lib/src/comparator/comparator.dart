part of '../../approval_tests.dart';

/// `Comparator` is an abstract class for comparing files.
abstract interface class Comparator {
  const Comparator();

  /// A method named `compare` for comparing two files.
  Future<void> compare({
    required String approvedPath,
    required String receivedPath,
  });
}

/// `ComparatorImp` is an abstract class for implementing the `Comparator` interface.
abstract class ComparatorImp implements Comparator {
  const ComparatorImp();

  /// A method named `logError` for logging errors.
  void logError(String message) {
    AppLogger.error('Error: $message');
  }
}
