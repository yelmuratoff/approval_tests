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
      try {
        ApprovalTests.verifyAsJson(complexObject, file: 'complex_json');
      } catch (e) {
        ApprovalTests.reporter.report('complex_json.approved.txt', 'complex_json.received.txt');
        rethrow;
      }
    });
  });

  // Additional tests...
}
