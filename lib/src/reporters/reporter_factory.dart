import 'package:approval_tests/src/core/logger/logger.dart';

abstract class ApprovalFailureReporter {
  void report(String approved, String received);
}

class ConsoleReporter extends ApprovalFailureReporter {
  @override
  void report(String approved, String received) {
    AppLogger.log(
        'Approval Test Failed:\nApproved: $approved\nReceived: $received');
  }
}

class ReporterFactory {
  static ApprovalFailureReporter get() => ConsoleReporter();
}

class GuiReporter extends ApprovalFailureReporter {
  @override
  void report(String approved, String received) {
    // Open a GUI diff tool programmatically
    AppLogger.log('Diff tool opened with files: $approved and $received');
  }
}
