part of '../../../approval_tests.dart';

// Define utility class for approval related operations. It contains methods for converting string cases and retrieving directory or file path.
final class ApprovalUtils {
  static AnsiPen hexToAnsiPen(String hex) {
    int red = int.parse(hex.substring(0, 2), radix: 16);
    int green = int.parse(hex.substring(2, 4), radix: 16);
    int blue = int.parse(hex.substring(4, 6), radix: 16);

    AnsiPen pen = AnsiPen()..rgb(r: red / 255, g: green / 255, b: blue / 255);
    return pen;
  }

  /// Computes the Cartesian product of a list of lists.
  static Iterable<List<T>> cartesianProduct<T>(List<List<T>> lists) {
    try {
      Iterable<List<T>> result = [[]];
      for (var list in lists) {
        result = result.expand((x) => list.map((y) => [...x, y]));
      }
      return result;
    } catch (e) {
      rethrow;
    }
  }

  // Property that gets the directory path of the current file.
  static String get directoryPath {
    return '${filePath.split('/').sublist(0, filePath.split('/').length - 1).join('/')}/'; // Get parts of the path except the last one (filename), join them with '/' and append '/' at the end.
  }

  // Property that gets the file name from file path.
  static String get fileName {
    return filePath
        .split('/')
        .last
        .split('.')
        .first; // Split the path by '/', get the last part (filename with extension), split it by '.', and get the first part (filename without extension).
  }

  // Property that gets the file path of the current file.
  static String get filePath {
    // final Uri uri = Platform.script; // Get the URL (Uniform Resource Identifier) of the script being run.
    // return Uri.decodeFull(uri.path); // Convert the URL-encoded path to a regular string.
    return DartScript.self.pathToScript;
  }

  static String readFile({
    required String path,
  }) {
    File file = File(path);
    return file.readAsStringSync();
  }

  static String lines(int count) {
    return List.filled(count, '=').join();
  }

  // Helper private method to check if contents of two files match
  static bool filesMatch(String approvedPath, String receivedPath) {
    try {
      // Read contents of the approved and received files
      var approved = ApprovalUtils.readFile(path: approvedPath);
      var received = ApprovalUtils.readFile(path: receivedPath);

      // Return true if contents of both files match exactly
      return approved == received;
    } catch (_) {
      rethrow;
    }
  }

  static void deleteFile(String path) {
    try {
      final File file = File(path);
      final bool exists = file.existsSync();
      if (exists) {
        file.deleteSync();
      }
    } catch (_) {
      rethrow;
    }
  }
}
