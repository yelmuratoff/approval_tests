part of '../../approval_dart.dart';

final class Comparator {
  /// `Comparator.compareFilesViaCommandLine` it is method for comparing files via Command Line.
  ///
  /// This method compares the content of two files line by line and prints the differences in the console.
  static void compareFilesViaCommandLine(String approvedContent, String receivedContent) {
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

  /// `Comparator.compareFilesViaVisualStudioCode` it is method for comparing files via Visual Studio Code.
  ///
  /// For this method to work, you need to have Visual Studio Code installed on your machine.
  /// And you need to have the `code` command available in your terminal.
  /// To enable the `code` command, press `Cmd + Shift + P` and type `Shell Command: Install 'code' command in PATH`.
  static void compareFilesViaVisualStudioCode(String approvedFilePath, String receivedFilePath) async {
    // Show file difference via Visual Studio Code
    try {
      await Process.run('code', ['--diff', approvedFilePath, receivedFilePath]);
    } catch (e) {
      AppLogger.error('Error during comparison via Visual Studio Code. Please try restart your IDE. Error: $e');
    }
  }

  /// `Comparator.compareFilesViaIntelliJ` it is method for comparing files via IntelliJ IDEA.
  ///
  /// For this method to work, you need to have IntelliJ IDEA installed on your machine.
  /// And you need to have the `idea` command available in your terminal.
  /// To enable the `idea` command, you need to create the command-line launcher using `Tools - Create Command-line Launcher` in IntelliJ IDEA.
  static void compareFilesViaIntelliJ(String approvedFilePath, String receivedFilePath) async {
    // Show file difference via IntelliJ IDEA
    try {
      await Process.run('idea', ['diff', approvedFilePath, receivedFilePath]);
    } catch (e) {
      AppLogger.error('Error during comparison via IntelliJ IDEA. Please try restart your IDE. Error: $e');
    }
  }

  /// `Comparator.compareFilesViaAndroidStudio` it is method for comparing files via Android Studio.
  ///
  /// For this method to work, you need to have Android Studio installed on your machine.
  /// And you need to have the `studio` command available in your terminal.
  /// To enable the `studio` command, you need to create the command-line launcher using `Tools - Create Command-line Launcher` in Android Studio.
  static void compareFilesViaAndroidStudio(String approvedFilePath, String receivedFilePath) async {
    // Show file difference via Android Studio
    try {
      await Process.run('studio', ['diff', receivedFilePath, approvedFilePath]);
    } catch (e) {
      AppLogger.error('Error during comparison via Android Studio. Please try restart your IDE. Error: $e');
    }
  }
}
