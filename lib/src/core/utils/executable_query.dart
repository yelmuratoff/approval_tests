part of '../../../approval_tests.dart';

abstract interface class ExecutableQuery {
  String getQuery();
  Future<String> executeQuery(String query);
}
