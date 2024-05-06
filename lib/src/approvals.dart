part of '../approval_dart.dart';

/// `ApprovalTests` is a class that provides methods to verify the content of a response.
class ApprovalTests {
  // Factory method to create an instance of ApprovalNamer with given file name
  static ApprovalNamer makeNamer(String file) => Namer(file);

  // Getter to fetch the reporter object from the ReporterFactory
  static ApprovalFailureReporter get reporter => ReporterFactory.reporter;

  // Method to verify if the content in response matches the approved content
  static void verify(String response,
      {Options options = const Options(), String? file, int? line}) {
    try {
      // Get the file path without extension or use the provided file path
      final completedPath = file ?? (ApprovalUtils.filePath).split('.').first;

      // Create namer object with given or computed file name
      final namer = makeNamer(file ?? completedPath);

      // Create writer object with scrubbed response and file extension retrieved from options
      final writer = ApprovalTextWriter(
          options.scrub(response), options.fileExtensionWithoutDot);

      // Write the content to a file whose path is specified in namer.received
      writer.writeToFile(namer.received);

      // Check if received file matches the approved file
      final bool isFilesMatch = _filesMatch(namer.approved, namer.received);

      // Log results and throw exception if files do not match
      if (!isFilesMatch) {
        AppLogger.log(
            'Approval Test Failed: ${namer.approved} does not match ${namer.received}');
        throw Exception('Content does not match approved file.');
      } else if (isFilesMatch) {
        AppLogger.good(
            'Approval Test Passed: ${namer.approved} matches ${namer.received}');
      }
    } on Exception catch (_) {
      rethrow;
    }
  }

  // Method to encode object to JSON and then verify it
  static void verifyAsJson(dynamic encodable,
      {Options options = const Options(),
      String? file,
      int? line,
      bool approveResult = false}) {
    try {
      // Encode the object into JSON format
      var jsonContent = jsonEncode(encodable);

      // Call the verify method on encoded JSON content
      verify(jsonContent, options: options, file: file, line: line);
    } on Exception catch (e, st) {
      AppLogger.logException(e, stackTrace: st);
      rethrow;
    }
  }

  // Method to convert a sequence of objects to string format and then verify it
  static void verifySequence(List<dynamic> sequence,
      {Options options = const Options(), String? file, int? line}) {
    try {
      // Convert the sequence of objects into a multiline string
      var content = sequence.map((e) => e.toString()).join('\n');

      // Call the verify method on this content
      verify(content, options: options, file: file, line: line);
    } on Exception catch (e, st) {
      AppLogger.logException(e, stackTrace: st);
    }
  }

  // Helper private method to check if contents of two files match
  static bool _filesMatch(String approvedPath, String receivedPath) {
    // Read contents of the approved and received files
    var approved = File(approvedPath).readAsStringSync();
    var received = File(receivedPath).readAsStringSync();

    // Return true if contents of both files match exactly
    return approved == received;
  }
}
