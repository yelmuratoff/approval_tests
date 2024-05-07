part of '../../approval_tests.dart';

/// `ApprovalNamer` class is used to generate the file names for the approved and received files.
class ApprovalNamer {
  final String file;

  const ApprovalNamer(this.file);

  // A getter named `approved` that returns the string `'file.approved.txt'`.
  String get approved => '$file.approved.txt';

  String get approvedFileName =>
      '${file.split('/').last.split('.').first}.approved.txt';

  // A getter named `received` that returns the string `'file.received.txt'`.
  String get received => '$file.received.txt';

  String get receivedFileName =>
      '${file.split('/').last.split('.').first}.received.txt';
}

// Define a class named `Namer` which extends the `ApprovalNamer` class.
class Namer extends ApprovalNamer {
  // A constructor for the class `Namer`. It calls the parent's constructor
  // with `file` as the argument.
  const Namer(super.file);
}
