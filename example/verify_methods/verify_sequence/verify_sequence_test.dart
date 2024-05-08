import 'package:approval_tests/approval_tests.dart';
import 'package:test/test.dart';

void main() {
  test('Verify sequence of numbers', () {
    List<int> sequence = [1, 2, 3, 4, 5];

    Approvals.verifySequence(
      sequence,
    );
  });
}
