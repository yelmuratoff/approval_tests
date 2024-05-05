part of '../approval_dart.dart';

class ApprovalTests {
  static ApprovalNamer makeNamer(String file) => Namer(file);

  static ApprovalFailureReporter get reporter => ReporterFactory.get();

  static void verify(String response,
      {Options options = const Options(), String? file, int? line}) {
    try {
      final completedPath = file ?? (ApprovalUtils.filePath).split('.').first;
      final namer = makeNamer(file ?? completedPath);
      final writer = ApprovalTextWriter(
          options.scrub(response), options.fileExtensionWithoutDot);
      writer.writeToFile(namer.received);
      final bool isFilesMatch = _filesMatch(namer.approved, namer.received);
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

  static void verifyAsJson(dynamic encodable,
      {Options options = const Options(),
      String? file,
      int? line,
      bool approveResult = false}) {
    try {
      var jsonContent = jsonEncode(encodable);
      verify(jsonContent, options: options, file: file, line: line);
    } on Exception catch (e, st) {
      AppLogger.logException(e, stackTrace: st);
      rethrow;
    }
  }

  static void verifySequence(List<dynamic> sequence,
      {Options options = const Options(), String? file, int? line}) {
    try {
      var content = sequence.map((e) => e.toString()).join('\n');
      verify(content, options: options, file: file, line: line);
    } on Exception catch (e, st) {
      AppLogger.logException(e, stackTrace: st);
    }
  }

  static bool _filesMatch(String approvedPath, String receivedPath) {
    var approved = File(approvedPath).readAsStringSync();
    var received = File(receivedPath).readAsStringSync();
    return approved == received;
  }
}
