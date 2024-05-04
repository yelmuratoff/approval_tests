import 'package:approval_tests/src/namer/approval_namer.dart';

class ApprovalNamer {
  final String file;

  ApprovalNamer(this.file);

  String get approved => '$file.approved.txt';
  String get received => '$file.received.txt';
}

class Namer extends ApprovalNamer {
  Namer(String file) : super(file);
}
