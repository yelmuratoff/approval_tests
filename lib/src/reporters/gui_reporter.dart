part of '../../approval_dart.dart';

/// `GuiReporter` is a concrete class for reporting approval failures to a GUI diff tool. Need to implement the `report` method.
class GuiReporter extends ApprovalFailureReporter {
  @override
  void report(String approved, String received) {
    // Open a GUI diff tool programmatically
    AppLogger.log('Diff tool opened with files: $approved and $received');
  }
}
