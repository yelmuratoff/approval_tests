import 'package:approval_tests/approval_tests.dart';
import 'package:test/test.dart';

void main() {
  var dbQuery = DatabaseRequestQuery("1");

  group('Approvals: pass cases', () {
    test('verify method', () {
      Approvals.verify(
        'Hello World',
        options: Options(
          filesPath: 'test/approved_files/verify',
          deleteReceivedFile: true,
        ),
      );
    });

    test('verifyAll method', () {
      Approvals.verifyAll(
        ['Hello World', 'Hello World'],
        processor: (item) {
          return item;
        },
        options: Options(
          filesPath: 'test/approved_files/verify_all',
          deleteReceivedFile: true,
        ),
      );
    });

    test('verifyAsJson method', () {
      Approvals.verifyAsJson(
        {"message": "Hello World"},
        options: Options(
          filesPath: 'test/approved_files/verify_as_json',
          deleteReceivedFile: true,
        ),
      );
    });

    test('verifyAllCombinations method', () {
      Approvals.verifyAllCombinations(
        [
          [1, 2],
          [3, 4]
        ],
        processor: (combination) => 'Combination: ${combination.join(", ")}',
        options: Options(
          filesPath: 'test/approved_files/verify_all_combinations',
          deleteReceivedFile: true,
        ),
      );
    });

    test("verify sequence", () {
      Approvals.verifySequence(
        [1, 2, 3],
        options: Options(
          deleteReceivedFile: true,
          filesPath: 'test/approved_files/verify_sequence',
        ),
      );
    });

    test("verify query", () async {
      await Approvals.verifyQuery(
        dbQuery,
        options: Options(
          deleteReceivedFile: true,
          filesPath: 'test/approved_files/verify_query',
        ),
      );
    });

    test("Does not match exception", () {
      expect(
        () => Approvals.verify(
          'Hello W0rld',
          options: Options(
            filesPath: 'test/approved_files/verify',
            deleteReceivedFile: true,
            logErrors: false,
          ),
        ),
        throwsA(isA<DoesntMatchException>()),
      );
    });
  });

  group('Approvals test for exceptions', () {
    test('verify method', () {
      expect(
        () => Approvals.verify(
          'Hello World',
          options: Options(
            filesPath: 'test/approved_files/verify_exception',
            deleteReceivedFile: true,
            logErrors: false,
          ),
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('verifyAll method', () {
      expect(
        () => Approvals.verifyAll(
          ['Hello World', 'Hello World'],
          processor: (item) {
            return item;
          },
          options: Options(
            filesPath: 'test/approved_files/verify_all_exception',
            deleteReceivedFile: true,
            logErrors: false,
          ),
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('verifyAsJson method', () {
      expect(
        () => Approvals.verifyAsJson(
          {"message": "Hello World"},
          options: Options(
            filesPath: 'test/approved_files/verify_as_json_exception',
            deleteReceivedFile: true,
            logErrors: false,
          ),
        ),
        throwsA(isA<Exception>()),
      );
    });

    // test('verifyAllCombinations method', () {
    //   expect(
    //     () => Approvals.verifyAllCombinations(
    //       [
    //         [1, 2],
    //         [3, 4]
    //       ],
    //       processor: (combination) => 'Combination: ${combination.join(", ")}',
    //       options: Options(
    //         approveResult: true,
    //         filesPath: 'test/approved_files/verify_all_combinations_exception',
    //       ),
    //     ),
    //     throwsA(isA<Exception>()),
    //   );
    // });

    // test("verify sequence", () {
    //   expect(
    //     () => Approvals.verifySequence(
    //       [1, 2, 3],
    //       options: Options(
    //         approveResult: true,
    //         filesPath: 'test/approved_files/verify_sequence_exception',
    //       ),
    //     ),
    //     throwsA(isA<Exception>()),
    //   );
    // });

    // test("verify query", () async {
    //   expect(
    //     () => Approvals.verifyQuery(
    //       dbQuery,
    //       options: Options(
    //         approveResult: true,
    //         filesPath: 'test/approved_files/verify_query_exception',
    //       ),
    //     ),
    //     throwsA(isA<Exception>()),
    //   );
    // });
  });
}

class DatabaseRequestQuery implements ExecutableQuery {
  final String userId;

  DatabaseRequestQuery(this.userId);

  @override
  String getQuery() => 'SELECT * FROM users WHERE id = $userId';

  @override
  Future<String> executeQuery(String query) async {
    // Simulate a database response
    await Future.delayed(Duration(milliseconds: 300)); // Simulate database latency
    // Mocked database response for the user details
    if (userId == "1") {
      return '{"id": "1", "name": "John Doe", "email": "john@example.com"}';
    } else {
      return 'Error: User not found';
    }
  }
}
