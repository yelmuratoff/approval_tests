import 'package:approval_tests/approval_tests.dart';
import 'package:test/test.dart';

void main() {
  test('Verify all items', () {
    List<String> items = ['apple', 'banana', 'cherry'];

    Approvals.verifyAll(
      items,
      processor: (item) => 'Item: $item',
      options: Options(deleteReceivedFile: true),
    );
  });
}
