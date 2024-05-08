import 'package:approval_tests/approval_tests.dart';
import 'package:test/test.dart';

void main() {
  group('ApprovalTests', () {
    test('verify method', () {
      ApprovalTests.verify(
        'Hello World',
        options: Options(),
      );
    });

    test('verifyAll method', () {
      ApprovalTests.verifyAll(
        inputs: ['Hello World', 'Hello World'],
        processor: (item) {
          return item;
        },
        options: Options(
          approveResult: true,
        ),
      );
    });
  });
}
