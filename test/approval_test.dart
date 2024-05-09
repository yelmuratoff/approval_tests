import 'package:approval_tests/approval_tests.dart';
import 'package:test/test.dart';

import '../example/verify_methods/verify_query/verify_db_query_test.dart';

part 'approval_test_config.dart';

void main() {
  final approvalsTestConfig = ApprovalTestConfig();
  final dbQuery = DatabaseRequestQuery("1");

  group('Approvals: pass cases |', () {
    test('Verify string with approved result options', () {
      approvalsTestConfig.verify('Hello World', 'verify', approveResult: true);
    });

    test('Verify all strings in a list', () {
      approvalsTestConfig.verifyAll(['Hello World', 'Hello World'], 'verify_all');
    });

    test('Verify JSON data', () {
      approvalsTestConfig.verifyAsJson({"message": "Hello World"}, 'verify_as_json');
    });

    test('Verify all combinations', () {
      approvalsTestConfig.verifyAllCombinations([
        [1, 2],
        [3, 4],
      ], 'verify_all_combinations');
    });

    test("Verify sequence", () {
      approvalsTestConfig.verifySequence([1, 2, 3], 'verify_sequence');
    });

    // Not work
    test("Verify query result", () async {
      await approvalsTestConfig.verifyQuery(dbQuery, 'verify_query');
    });

    // Work
    test("verify query", () async {
      await Approvals.verifyQuery(
        dbQuery,
        options: Options(
          deleteReceivedFile: true,
          filesPath: 'test/approved_files/verify_query',
        ),
      );
    });
  });

  group('Approvals test for exceptions |', () {
    test('Verify method should throw', () {
      expect(
        () => approvalsTestConfig.verify('Hello World', 'verify_exception', expectException: true),
        throwsA(isA<Exception>()),
      );
    });

    test('Verify all method should throw', () {
      expect(
        () => approvalsTestConfig.verifyAll(['Hello World', 'Hello World'], 'verify_exception', expectException: true),
        throwsA(isA<Exception>()),
      );
    });

    test('VerifyAsJson method should throw', () {
      expect(
        () => approvalsTestConfig.verifyAsJson({"message": "Hello World"}, 'verify_as_json_exception', expectException: true),
        throwsA(isA<Exception>()),
      );
    });

    test('Verify all combinations method should throw', () {
      expect(
        () => approvalsTestConfig.verifyAllCombinations([
          [1, 2],
          [3, 4],
        ], 'verify_all_combinations_exception', expectException: true),
        throwsA(isA<Exception>()),
      );
    });

    test("Verify sequence method should throw", () {
      expect(
        () => approvalsTestConfig.verifySequence([1, 2, 3], 'verify_sequence_exception', expectException: true),
        throwsA(isA<Exception>()),
      );
    });

    test("Verify query method should throw", () async {
      expect(
        () => approvalsTestConfig.verifyQuery(dbQuery, 'verify_query_exception', expectException: true),
        throwsA(isA<Exception>()),
      );
    });

    test("Does not match exception", () {
      expect(
        () => approvalsTestConfig.verify(
          'Hello W0rld',
          'verify',
          expectException: true,
          deleteReceivedFile: true,
        ),
        throwsA(isA<DoesntMatchException>()),
      );
    });

    test("Log error test", () {
      expect(
        () => approvalsTestConfig.verify(
          'Hello W0rld',
          'verify',
          expectException: false,
          deleteReceivedFile: true,
        ),
        throwsA(isA<DoesntMatchException>()),
      );
    });
  });
}
