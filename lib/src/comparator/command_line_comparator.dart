part of '../../approval_tests.dart';

/// `CommandLineComparator` it is for comparing files via Command Line.
///
/// This method compares the content of two files line by line and prints the differences in the console.
final class CommandLineComparator extends ComparatorImp {
  const CommandLineComparator();

  @override
  Future<void> compare({
    required String approvedPath,
    required String receivedPath,
  }) async {
    try {
      final String approvedContent = File(approvedPath).readAsStringSync();
      final String receivedContent = File(receivedPath).readAsStringSync();

      final StringBuffer buffer = StringBuffer("Differences:\n");
      List<String> approvedLines = approvedContent.split('\n');
      List<String> receivedLines = receivedContent.split('\n');

      int maxLines = max(approvedLines.length, receivedLines.length);
      for (int i = 0; i < maxLines; i++) {
        if (i >= approvedLines.length ||
            i >= receivedLines.length ||
            approvedLines[i] != receivedLines[i]) {
          buffer.writeln(
              '${ApprovalUtils.lines(20)} Difference at line ${i + 1} ${ApprovalUtils.lines(20)}');
          buffer.writeln(
              'Approved file: ${i < approvedLines.length ? approvedLines[i] : "No content"}');
          buffer.writeln(
              'Received file: ${i < receivedLines.length ? receivedLines[i] : "No content"}');
        }
      }

      if (buffer.isNotEmpty) {
        final String message = buffer.toString();
        logError(message.trim());
      }
    } catch (e) {
      logError('Error during comparison via Command Line. Error: $e');
      rethrow;
    }
  }
}
