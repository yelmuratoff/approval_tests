import 'package:approval_tests/approval_tests.dart';
import 'package:test/test.dart';

void main() {
  test('Verify method', () {
    String response =
        '{"result": "success", "data": {"id": 1, "name": "Item"}}';

    try {
      ApprovalTests.verify(
        response,
      );
    } catch (e) {
      print('Verification failed: $e');
    }
  });
}
