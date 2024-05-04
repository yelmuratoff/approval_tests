import 'dart:convert';
import 'dart:io';
import 'package:test/test.dart';

/// A utility class for verifying test cases and saving approved test cases.
final class ApprovalDart {
  static final String _defaultPath = _initializeDefaultPath();

  /// Prevents instantiation of the ApprovalDart class.
  const ApprovalDart._();

  /// Initializes and returns the default path based on the script's directory.
  static String _initializeDefaultPath() {
    String path = directoryPath();
    return "${path}approved_cases.g.dart";
  }

  /// Returns the path to the approved test cases file.
  static String approvedPath() {
    String path = directoryPath();
    return "${path}approved_cases.txt";
  }

  /// Returns the directory path of the script.
  static String directoryPath() {
    String currentPath = Platform.script.path;
    String result = currentPath.substring(0, currentPath.lastIndexOf('/') + 1);
    return result;
  }

  /// Executes tests on all combinations of given input sets.
  static void verifyAllCombinations(List<List<dynamic>> inputSets, void Function(Iterable<List> list) testFunction) {
    Iterable<List> combinations = _cartesianProduct(inputSets);
    testFunction.call(combinations);
  }

  /// Verifies the output against the approved file.
  static void verify(String output, {String? filePath}) {
    File file = File(filePath ?? approvedPath());
    if (!file.existsSync()) {
      file.writeAsStringSync(output);
      print("Error: Approved file does not exist.");
    } else {
      String approvedOutput = file.readAsStringSync();
      bool isApproved = output == approvedOutput;
      print("Output: '$output'\n\nApproved: '$approvedOutput'");
      if (!isApproved) {
        throw Exception("Output does not match the approved file.");
      }
      print("Output matches the approved file.");
      expect(output, equals(approvedOutput));
    }
  }

  /// Saves approved test cases to a Dart file.
  static void saveApprovedCase(dynamic approvedCase, {String? filePath, String? fileName}) {
    saveCases(null, approvedCase, filePath: filePath, fileName: fileName);
  }

  /// Saves approved test cases to a Dart file.
  static void saveCases(dynamic receivedItems, dynamic expectedItems, {String? filePath, String? fileName}) {
    if (receivedItems is List && expectedItems is List) {
      List<Map<String, dynamic>> approvedCases = [];
      for (int i = 0; i < receivedItems.length; i++) {
        approvedCases.add({
          "received": receivedItems[i].toJson(),
          "expected": expectedItems[i].toJson(),
        });
      }
      final String name = fileName != null ? _toCamelCaseFromSnakeCase(fileName.replaceAll(".g.dart", "")) : "approvedCases";
      File file = File(filePath ?? (fileName != null ? directoryPath() + fileName : _defaultPath));

      var buffer = StringBuffer();
      buffer.writeln("const $name = [");
      for (var testCase in approvedCases) {
        buffer.writeln("  ${jsonEncode(testCase)}${testCase == approvedCases.last ? "" : ","}");
      }
      buffer.writeln("];");
      file.writeAsStringSync(buffer.toString());
    } else if (expectedItems is! List && receivedItems == null) {
      var approvedBuffer = StringBuffer();

      final String approvedName = "approved_cases.txt";

      approvedBuffer.writeln(expectedItems);

      File approvedFile = File(filePath ?? directoryPath() + approvedName);

      approvedFile.writeAsStringSync(approvedBuffer.toString());

      print("Approved cases have been saved.");
    }
  }

  /// Loads approved test cases from a Dart file.
  static List<dynamic> loadApprovedCasesIfExists({String? filePath}) {
    late File file = File(filePath ?? _defaultPath);
    if (file.existsSync()) {
      String content = file.readAsStringSync();
      return jsonDecode(content);
    }
    return [];
  }

  /// Checks if the approved test cases file exists.
  static bool isValuesApproved({String? path}) {
    final bool fileExists = File(path ?? _defaultPath).existsSync();
    return fileExists;
  }

  /// Deletes the approved test cases file if it exists.
  static void deleteApprovedCasesIfExists({String? path}) {
    File file = File(path ?? _defaultPath);
    if (file.existsSync()) {
      file.deleteSync();
    }
  }
}

/// Computes the Cartesian product of a list of lists.
Iterable<List<T>> _cartesianProduct<T>(List<List<T>> lists) {
  Iterable<List<T>> result = [[]];
  for (var list in lists) {
    result = result.expand((x) => list.map((y) => [...x, y]));
  }
  return result;
}

/// Converts a snake_case string to camelCase.
String _toCamelCaseFromSnakeCase(String snakeCase) {
  List<String> parts = snakeCase.split('_');
  String camelCase = parts[0];
  for (int i = 1; i < parts.length; i++) {
    camelCase += parts[i].substring(0, 1).toUpperCase() + parts[i].substring(1);
  }
  return camelCase;
}
