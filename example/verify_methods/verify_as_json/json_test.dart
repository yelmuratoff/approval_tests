import 'package:approval_tests/approval_tests.dart';
import 'package:test/test.dart';

void main() {
  group('Approval Tests for Complex Objects', () {
    test('test complex JSON object', () {
      var complexObject = {
        'name': 'JsonTest',
        'features': ['Testing', 'JSON'],
        'version': 0.1,
      };
      Approvals.verifyAsJson(
        complexObject,
        options: Options(deleteReceivedFile: true),
      );
    });
  });
}
