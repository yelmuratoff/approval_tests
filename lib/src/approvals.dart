part of '../approval_dart.dart';

class ApprovalTests {
  static ApprovalNamer makeNamer(String file) => Namer(file);

  static ApprovalFailureReporter get reporter => ReporterFactory.get();

  static void verify(String response, {Options options = const Options(), String? file, int? line}) {
    var namer = makeNamer(file ?? 'default');
    var writer = ApprovalTextWriter(options.scrub(response), options.fileExtensionWithoutDot);
    writer.writeToFile(namer.received);

    if (!_filesMatch(namer.approved, namer.received)) {
      throw Exception('Content does not match approved file.');
    }
  }

  static void verifyAsJson(dynamic encodable, {Options options = const Options(), String? file, int? line}) {
    var jsonContent = jsonEncode(encodable);
    verify(jsonContent, options: options, file: file, line: line);
  }

  static void verifySequence(List<dynamic> sequence, {Options options = const Options(), String? file, int? line}) {
    var content = sequence.map((e) => e.toString()).join('\n');
    verify(content, options: options, file: file, line: line);
  }

  static bool _filesMatch(String approvedPath, String receivedPath) {
    var approved = File(approvedPath).readAsStringSync();
    var received = File(receivedPath).readAsStringSync();
    return approved == received;
  }
}
