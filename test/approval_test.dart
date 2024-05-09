import 'package:approval_tests/approval_tests.dart';
import 'package:test/test.dart';

import 'models/item.dart';
import 'queries/db_request_query.dart';

part 'approval_test_config.dart';
part 'constants/lines.dart';

void main() {
  const helper = ApprovalTestHelper();
  const dbQuery = DatabaseRequestQuery("1");
  final lines = _Lines.lines25;

  setUpAll(() {
    ApprovalLogger.log("$lines Tests are starting $lines");
  });

  group('Approvals: pass cases |', () {
    setUpAll(() {
      ApprovalLogger.log("$lines Group: Pass cases are starting $lines");
    });
    test('Verify string with approved result options', () {
      helper.verify('Hello World', 'verify', approveResult: true);
    });

    test('Verify all strings in a list', () {
      helper.verifyAll(['Hello World', 'Hello World'], 'verify_all');
    });

    test('Verify JSON data', () {
      helper.verifyAsJson({"message": "Hello World"}, 'verify_as_json');
    });

    test('Verify JSON data: with model', () {
      helper.verifyAsJson(ApprovalTestHelper.jsonItem, 'verify_as_model_json');
    });

    test('Verify all combinations', () {
      helper.verifyAllCombinations([
        [1, 2],
        [3, 4],
      ], 'verify_all_combinations');
    });

    test("Verify sequence", () {
      helper.verifySequence([1, 2, 3], 'verify_sequence');
    });

    // Not work
    test("Verify query result", () async {
      await helper.verifyQuery(dbQuery, 'verify_query');
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
    setUpAll(() {
      ApprovalLogger.error("$lines Group: Exception cases are starting $lines");
    });
    test('Verify method should throw', () {
      expect(
        () => helper.verify('Hello World', 'verify_exception',
            expectException: true),
        throwsA(isA<Exception>()),
      );
    });

    test('Verify all method should throw', () {
      expect(
        () => helper.verifyAll(
            ['Hello World', 'Hello World'], 'verify_exception',
            expectException: true),
        throwsA(isA<Exception>()),
      );
    });

    test('VerifyAsJson method should throw', () {
      expect(
        () => helper.verifyAsJson(
            {"message": "Hello World"}, 'verify_as_json_exception',
            expectException: true),
        throwsA(isA<Exception>()),
      );
    });

    test('Verify all combinations method should throw', () {
      expect(
        () => helper.verifyAllCombinations([
          [1, 2],
          [3, 4],
        ], 'verify_all_combinations_exception', expectException: true),
        throwsA(isA<Exception>()),
      );
    });

    test("Verify sequence method should throw", () {
      expect(
        () => helper.verifySequence([1, 2, 3], 'verify_sequence_exception',
            expectException: true),
        throwsA(isA<Exception>()),
      );
    });

    test("Verify query method should throw", () async {
      expect(
        () => helper.verifyQuery(dbQuery, 'verify_query_exception',
            expectException: true),
        throwsA(isA<Exception>()),
      );
    });

    test("Does not match exception", () {
      expect(
        () => helper.verify(
          'Hello W0rld',
          'verify',
          expectException: true,
          deleteReceivedFile: true,
        ),
        throwsA(isA<DoesntMatchException>()),
      );
    });

    test("Log does not match exception", () {
      expect(
        () => helper.verify(
          'Hello W0rld',
          'verify',
          expectException: false,
          deleteReceivedFile: true,
        ),
        throwsA(isA<DoesntMatchException>()),
      );
    });
  });

  tearDownAll(() {
    ApprovalLogger.log("$lines All tests are done $lines");
  });
}
