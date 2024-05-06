part of '../../approval_dart.dart';

/// `ApprovalFailureReporter` is an abstract class for reporting approval failures.
abstract class ApprovalFailureReporter {
  /// Report the approval failure.
  void report(String approved, String received);
}
