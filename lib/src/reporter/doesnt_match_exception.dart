part of '../../approval_dart.dart';

/// Exception thrown when the actual value doesn't match the expected value.
final class DoesntMatchException implements Exception {
  final String message;

  const DoesntMatchException(this.message);

  @override
  String toString() => message;
}
