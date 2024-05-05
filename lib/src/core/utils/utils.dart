import 'dart:io';

final class ApprovalUtils {
  /// Converts a string from snake_case to camelCase.
  static String toCamelCaseFromSnakeCase(String snakeCase) {
    return snakeCase.split('_').map((String word) {
      return word[0].toUpperCase() + word.substring(1);
    }).join('');
  }

  /// Converts a string from camelCase to snake_case.
  static String toSnakeCaseFromCamelCase(String camelCase) {
    return camelCase
        .split('')
        .map((String letter) {
          return letter == letter.toUpperCase() ? '_${letter.toLowerCase()}' : letter;
        })
        .join('')
        .substring(1);
  }

  /// Returns the directory path of the current file.
  static String get directoryPath {
    return '${Platform.script.path.split('/').sublist(0, Platform.script.path.split('/').length - 1).join('/')}/';
  }

  static String get fileName {
    return filePath.split('/').last.split('.').first;
  }

  /// Returns the file path of the current file.
  static String get filePath {
    final Uri uri = Platform.script;
    return Uri.decodeFull(uri.path);
  }
}
