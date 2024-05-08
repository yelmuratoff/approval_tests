import 'dart:convert';
import 'dart:io';

import 'package:approval_tests/approval_tests.dart';

void main() async {
  var query = NetworkRequestQuery(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));
  await Approvals.verifyQuery(query);
}

class NetworkRequestQuery implements ExecutableQuery {
  final Uri endpoint;

  NetworkRequestQuery(this.endpoint);

  @override
  String getQuery() => 'GET ${endpoint.toString()}';

  @override
  Future<String> executeQuery(String query) async {
    var client = HttpClient();
    try {
      var request = await client.getUrl(endpoint);
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        var responseBody = await response.transform(utf8.decoder).join();
        return responseBody;
      } else {
        return 'Error: ${response.statusCode}';
      }
    } catch (e) {
      return 'Exception: $e';
    } finally {
      client.close();
    }
  }
}
