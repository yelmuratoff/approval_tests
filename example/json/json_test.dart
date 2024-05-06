import 'package:approval_tests/approval_dart.dart';
import 'package:test/test.dart';

void main() {
  group('Approval Tests for Complex Objects', () {
    test('should approve complex JSON object', () {
      var complexObject = {
        'name': 'JsonTest',
        'features': ['Testing', 'JSON'],
        'version': 0.1,
      };
      ApprovalTests.verifyAsJson(complexObject, approveResult: true);
    });
  });
}
