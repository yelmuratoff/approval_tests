part of '../../../approval_tests.dart';

/// Extension on [String] to verify the content of a response.
extension ApprovalString on String {
  void verify({Options options = const Options(), String? file, int? line}) {
    ApprovalTests.verify(this, options: options, file: file, line: line);
  }

  void verifyAsJson(
      {Options options = const Options(), String? file, int? line}) {
    ApprovalTests.verifyAsJson(this, options: options, file: file, line: line);
  }
}
