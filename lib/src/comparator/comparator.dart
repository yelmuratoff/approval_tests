part of '../../approval_dart.dart';

final class Comparator {
  static void compareFilesInCommandLine(String approvedContent, String receivedContent) {
    final StringBuffer buffer = StringBuffer("Differences:\n");
    List<String> approvedLines = approvedContent.split('\n');
    List<String> receivedLines = receivedContent.split('\n');

    int maxLines = max(approvedLines.length, receivedLines.length);
    for (int i = 0; i < maxLines; i++) {
      if (i >= approvedLines.length || i >= receivedLines.length || approvedLines[i] != receivedLines[i]) {
        buffer.writeln('${ApprovalUtils.lines(20)} Difference at line ${i + 1} ${ApprovalUtils.lines(20)}');
        buffer.writeln('Approved file: ${i < approvedLines.length ? approvedLines[i] : "No content"}');
        buffer.writeln('Received file: ${i < receivedLines.length ? receivedLines[i] : "No content"}');
      }
    }

    if (buffer.isNotEmpty) {
      final String message = buffer.toString();
      AppLogger.error(message.trim());
    }
  }
}
