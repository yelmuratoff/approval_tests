import 'package:approval_tests/approval_tests.dart';

import '../../../test/queries/db_request_query.dart';

void main() async {
  var dbQuery = DatabaseRequestQuery("1");
  await Approvals.verifyQuery(
    dbQuery,
    options: Options(deleteReceivedFile: true),
  );
}
