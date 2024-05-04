abstract class ApprovalFailureReporter {
  void report(String approved, String received);
}

class ConsoleReporter extends ApprovalFailureReporter {
  @override
  void report(String approved, String received) {
    print('Approval Test Failed:\nApproved: $approved\nReceived: $received');
  }
}

class ReporterFactory {
  static ApprovalFailureReporter get() => ConsoleReporter();
}

class GuiReporter extends ApprovalFailureReporter {
  @override
  void report(String approved, String received) {
    // Open a GUI diff tool programmatically
    print('Diff tool opened with files: $approved and $received');
  }
}
