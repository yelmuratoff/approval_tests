part of '../../../approval_dart.dart';

/// Extension on [String] to verify the content of a response.
extension ApprovalString on String {
  void verify({Options options = const Options(), String? file, int? line, bool approveResult = false}) {
    ApprovalTests.verify(this, options: options, file: file, line: line, approveResult: approveResult);
  }

  void verifyAsJson({Options options = const Options(), String? file, int? line, bool approveResult = false}) {
    ApprovalTests.verifyAsJson(this, options: options, file: file, line: line, approveResult: approveResult);
  }
}
