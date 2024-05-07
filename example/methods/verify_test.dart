import 'package:approval_tests/approval_dart.dart';
import 'package:test/test.dart';

void main() {
  test('Verify method', () {
    // Simulated response from a function
    String response = '{"result": "success", "data": {"id": 1, "name": "Item"}}';

    try {
      ApprovalTests.verify(
        response,
        file: 'example/methods/verify',
      );
    } catch (e) {
      print('Verification failed: $e');
    }
  });
}
