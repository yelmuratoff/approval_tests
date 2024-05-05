import 'package:approval_tests/approval_dart.dart';
import 'package:test/test.dart';

void main() {
  group('Approval Tests for Complex Objects', () {
    test('should approve complex JSON object', () {
      var complexObject = {
        'name': 'ChatGPT',
        'features': ['AI', 'Conversational'],
        'version': 4.0
      };
      ApprovalTests.verifyAsJson(complexObject, approveResult: true);
    });
  });

  // Additional tests...
}
