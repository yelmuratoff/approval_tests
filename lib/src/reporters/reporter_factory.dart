part of '../../approval_dart.dart';

/// `ReporterFactory` is a factory class for creating `ApprovalFailureReporter` objects.
class ReporterFactory {
  static ApprovalFailureReporter get reporter => ConsoleReporter();
}
