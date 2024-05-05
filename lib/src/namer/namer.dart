class ApprovalNamer {
  final String file;

  ApprovalNamer(this.file);

  String get approved => '$file.approved.txt';
  String get received => '$file.received.txt';
}

class Namer extends ApprovalNamer {
  Namer(super.file);
}
