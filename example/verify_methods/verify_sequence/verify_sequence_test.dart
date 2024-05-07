import 'package:approval_tests/approval_dart.dart';
import 'package:test/test.dart';

void main() {
  test('Verify sequence of numbers', () {
    List<int> sequence = [1, 2, 3, 4, 5];

    ApprovalTests.verifySequence(
      sequence,
    );
  });
}
