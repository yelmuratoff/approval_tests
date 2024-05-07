import 'package:approval_tests/approval_tests.dart';
import 'package:test/test.dart';

void main() {
  test('Verify all combinations of input values', () {
    List<List<int>> inputs = [
      [1, 2],
      [3, 4]
    ];

    ApprovalTests.verifyAllCombinations(
      inputs: inputs,
      processor: (combination) => 'Combination: ${combination.join(", ")}',
    );
  });
}
