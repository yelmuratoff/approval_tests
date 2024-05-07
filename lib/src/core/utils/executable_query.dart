part of '../../../approval_dart.dart';

abstract interface class ExecutableQuery {
  String getQuery();
  Future<String> executeQuery(String query);
}
