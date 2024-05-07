import 'dart:async';

import 'package:approval_tests/approval_dart.dart';

class DatabaseRequestQuery implements ExecutableQuery {
  final String userId;

  DatabaseRequestQuery(this.userId);

  @override
  String getQuery() => 'SELECT * FROM users WHERE id = $userId';

  @override
  Future<String> executeQuery(String query) async {
    // Simulate a database response
    await Future.delayed(Duration(seconds: 1)); // Simulate database latency
    // Mocked database response for the user details
    if (userId == "1") {
      return '{"id": "1", "name": "John Doe", "email": "john@example.com"}';
    } else {
      return 'Error: User not found';
    }
  }
}

void main() async {
  var dbQuery = DatabaseRequestQuery("1");
  ApprovalTests.verifyQuery(
    dbQuery,
  );
}
