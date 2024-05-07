part of '../../../approval_tests.dart';

// Define utility class for approval related operations. It contains methods for converting string cases and retrieving directory or file path.
final class ApprovalUtils {
  // Method that converts a snake_case string to camelCase.
  static String toCamelCaseFromSnakeCase(String snakeCase) {
    return snakeCase.split('_').map((String word) {
      // Split the snake_case string by '_'
      return word[0].toUpperCase() + word.substring(1); // Capitalize the first character of each word and concatenate the rest of the string.
    }).join(''); // Join all the words to form a string.
  }

  // Method that converts a camelCase string to snake_case.
  static String toSnakeCaseFromCamelCase(String camelCase) {
    return camelCase
        .split('') // Split the camelCase string into individual letters.
        .map((String letter) {
          return letter == letter.toUpperCase()
              ? '_${letter.toLowerCase()}'
              : letter; // If the letter is uppercase, prepend '_' and convert it to lowercase. Else, just use the letter.
        })
        .join('') // Join all the letters to form a string.
        .substring(1); // Remove the first '_' that was added before the first word.
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
      AppLogger.exception(e);
      rethrow;
    }
  }

  // Property that gets the directory path of the current file.
  static String get directoryPath {
    return '${Platform.script.path.split('/').sublist(0, filePath.split('/').length - 1).join('/')}/'; // Get parts of the path except the last one (filename), join them with '/' and append '/' at the end.
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

  static Future<String> readFile({
    required String path,
  }) async {
    File file = File(path);
    return await file.readAsString();
  }

  static String lines(int count) {
    return List.filled(count, '=').join();
  }

  // Helper private method to check if contents of two files match
  static bool filesMatch(String approvedPath, String receivedPath) {
    try {
      // Read contents of the approved and received files
      var approved = File(approvedPath).readAsStringSync();
      var received = File(receivedPath).readAsStringSync();

      // Return true if contents of both files match exactly
      return approved == received;
    } catch (e) {
      AppLogger.exception(e);
      rethrow;
    }
  }
}
