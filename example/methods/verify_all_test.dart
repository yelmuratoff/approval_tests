import 'package:approval_tests/approval_dart.dart';
import 'package:test/test.dart';

void main() {
  test('Verify all items', () {
    List<String> items = ['apple', 'banana', 'cherry'];

    ApprovalTests.verifyAll(
      inputs: items,
      processor: (item) => 'Item: $item',
      file: 'example/methods/verify_all',
    );
  });
}
