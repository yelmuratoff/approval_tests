part of '../../approval_dart.dart';

/// `ConsoleReporter` is a concrete class for reporting approval failures to the console.
class ConsoleReporter extends ApprovalFailureReporter {
  @override
  void report(String approved, String received) {
    AppLogger.log(
        'Approval Test Failed:\nApproved: $approved\nReceived: $received');
  }
}
