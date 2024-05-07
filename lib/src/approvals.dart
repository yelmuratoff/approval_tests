part of '../approval_dart.dart';

/// `ApprovalTests` is a class that provides methods to verify the content of a response.
class ApprovalTests {
  // Factory method to create an instance of ApprovalNamer with given file name
  static ApprovalNamer makeNamer(String file) => Namer(file);

  // ================== Verify methods ==================

  // Method to verify if the content in response matches the approved content
  static void verify(String response, {Options options = const Options(), String? file, int? line, bool approveResult = false}) {
    try {
      // Get the file path without extension or use the provided file path
      final completedPath = file ?? (ApprovalUtils.filePath).split('.').first;

      // Create namer object with given or computed file name
      final namer = makeNamer(file ?? completedPath);

      // Create writer object with scrubbed response and file extension retrieved from options
      final writer = ApprovalTextWriter(options.scrub(response), options.fileExtensionWithoutDot);

      // Write the content to a file whose path is specified in namer.received
      writer.writeToFile(namer.received);

      if (approveResult) {
        writer.writeToFile(namer.approved);
      }

      // Check if received file matches the approved file
      final bool isFilesMatch = _filesMatch(namer.approved, namer.received);

      // Log results and throw exception if files do not match
      if (!isFilesMatch) {
        options.comparator.compare(approvedPath: namer.approved, receivedPath: namer.received);
        throw DoesntMatchException('Test failed: ${namer.approved} does not match ${namer.received}');
      } else if (isFilesMatch) {
        AppLogger.success('Test passed: [${namer.approvedFileName}] matches [${namer.receivedFileName}]');
      }
    } catch (_) {
      rethrow;
    }
  }

  /// Verifies all combinations of inputs for a provided function.
  static void verifyAll<T>({
    required List<T> inputs,
    required String Function(T item) processor,
    Options options = const Options(),
    String? file,
    int? line,
    bool approveResult = false,
  }) {
    try {
      // Process the combination to get the response
      final response = inputs.map((e) => processor(e));

      final responseString = response.join('\n');

      // Verify the processed response
      verify(responseString, options: options, file: file, line: line, approveResult: approveResult);
    } catch (e, st) {
      AppLogger.exception(e, stackTrace: st);
      rethrow;
    }
  }

  // Method to encode object to JSON and then verify it
  static void verifyAsJson(dynamic encodable, {Options options = const Options(), String? file, int? line, bool approveResult = false}) {
    try {
      // Encode the object into JSON format
      var jsonContent = _encodeReflectively(encodable);

      // Call the verify method on encoded JSON content
      verify(jsonContent, options: options, file: file, line: line, approveResult: approveResult);
    } catch (e, st) {
      AppLogger.exception(e, stackTrace: st);
      rethrow;
    }
  }

  // Method to convert a sequence of objects to string format and then verify it
  static void verifySequence(List<dynamic> sequence, {Options options = const Options(), String? file, int? line, bool approveResult = false}) {
    try {
      // Convert the sequence of objects into a multiline string
      var content = sequence.map((e) => e.toString()).join('\n');

      // Call the verify method on this content
      verify(content, options: options, file: file, line: line, approveResult: approveResult);
    } catch (e, st) {
      AppLogger.exception(e, stackTrace: st);
      rethrow;
    }
  }

  /// Verifies the output of a query. The query is processed to get the response, which is then verified.
  static void verifyQuery<T>({
    required T query,
    required String Function(T query) processor,
    Options options = const Options(),
    String? file,
    int? line,
    bool approveResult = false,
  }) {
    try {
      // Process the query to get the response
      final response = processor(query);

      // Verify the processed response
      verify(response, options: options, file: file, line: line, approveResult: approveResult);
    } catch (e, st) {
      AppLogger.exception(e, stackTrace: st);
      rethrow;
    }
  }

  // ================== Combinations ==================

  /// Verifies all combinations of inputs for a provided function.
  static void verifyAllCombinations<T>({
    required List<List<T>> inputs,
    required String Function(Iterable<List<T>> combination) processor,
    Options options = const Options(),
    String? file,
    int? line,
    bool approveResult = false,
  }) {
    // Generate all combinations of inputs
    final combinations = _cartesianProduct(inputs);

    // Iterate over each combination, apply the processor function, and verify the result

    try {
      // Process the combination to get the response
      final response = processor(combinations);

      // Verify the processed response
      verify(response, options: options, file: file, line: line, approveResult: approveResult);
    } catch (e, st) {
      AppLogger.exception(e, stackTrace: st);
      rethrow;
    }
  }

  static void verifyAllCombinationsAsJson<T>({
    required List<List<T>> inputs,
    required dynamic Function(Iterable<List<T>> combination) processor,
    Options options = const Options(),
    String? file,
    int? line,
    bool approveResult = false,
  }) {
    // Generate all combinations of inputs
    final combinations = _cartesianProduct(inputs);

    // Iterate over each combination, apply the processor function, and verify the result

    try {
      // Process the combination to get the response
      final response = processor(combinations);

      // Verify the processed response
      verifyAsJson(response, options: options, file: file, line: line, approveResult: approveResult);
    } catch (e, st) {
      AppLogger.exception(e, stackTrace: st);
      rethrow;
    }
  }

  // ================== Helper methods ==================

  /// Computes the Cartesian product of a list of lists.
  static Iterable<List<T>> _cartesianProduct<T>(List<List<T>> lists) {
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

  // Helper private method to check if contents of two files match
  static bool _filesMatch(String approvedPath, String receivedPath) {
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

  static String _encodeReflectively(Object? object) {
    if (object == null) {
      return 'null';
    }

    if (object is List) {
      // Handle lists of objects by iterating through them
      return '[${object.map((item) => _encodeReflectively(item)).join(', ')}]';
    }

    if (object is Map) {
      // Handle maps directly
      return '{${object.entries.map((e) => '"${e.key}": ${_encodeReflectively(e.value)}').join(', ')}}';
    }

    // Reflect the object
    InstanceMirror mirror = reflect(object);
    ClassMirror classMirror = mirror.type;

    if (object is String) {
      // JSON encode strings with proper escaping
      return '"${object.replaceAll('"', '\\"')}"';
    } else if (object is num || object is bool) {
      // Numbers and booleans can be added directly
      return object.toString();
    }

    // Handling custom objects
    Map<String, String> jsonMap = {};

    // Iterate over the instance variables of the class
    for (var v in classMirror.declarations.values) {
      if (v is VariableMirror && !v.isStatic) {
        String key = MirrorSystem.getName(v.simpleName);
        var value = mirror.getField(v.simpleName).reflectee;
        jsonMap[key] = _encodeReflectively(value);
      }
    }

    // Format the map into JSON
    return '{${jsonMap.entries.map((entry) => '"${entry.key}": ${entry.value}').join(', ')}}';
  }

  // /// Encodes an object to JSON format using reflection.
  // static String _encodeReflectively(Object? object) {
  //   if (object == null) {
  //     return 'Object{}';
  //   }

  //   if (object is List) {
  //     // Handle lists of objects by iterating through them
  //     List<String> items = [];
  //     for (int i = 0; i < object.length; i++) {
  //       items.add(_encodeReflectively(object[i]));
  //     }
  //     return items.join(', ');
  //   }

  //   // Reflect the object
  //   InstanceMirror mirror = reflect(object);
  //   ClassMirror classMirror = mirror.type;

  //   String className = MirrorSystem.getName(classMirror.simpleName);
  //   Map<String, dynamic> jsonMap = {};

  //   // Iterate over the instance variables of the class
  //   for (var v in classMirror.declarations.values) {
  //     if (v is VariableMirror && !v.isStatic) {
  //       String key = MirrorSystem.getName(v.simpleName);
  //       var value = mirror.getField(v.simpleName).reflectee;

  //       // Check if the value is a basic data type or needs recursive processing
  //       if (value is String || value is num || value is bool) {
  //         jsonMap[key] = value;
  //       } else {
  //         // Recursively encode nested objects
  //         jsonMap[key] = _encodeReflectively(value);
  //       }
  //     }
  //   }

  //   // Format the map into the desired string format
  //   String properties = jsonMap.entries.map((entry) => '${entry.key}: ${entry.value}').join(', ');
  //   return '$className{$properties}';
  // }
}
