import 'dart:io';

import 'package:approval_tests/approval_tests.dart';
import 'package:test/test.dart';

void main() {
  group('ApprovalTests', () {
    test('verify method', () {
      ApprovalTests.verify(
        'Hello World',
        options: Options(),
      );
    });
  });
}
