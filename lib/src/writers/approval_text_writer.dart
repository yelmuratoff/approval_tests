part of '../../approval_dart.dart';

class ApprovalTextWriter {
  final String content;
  final String fileExtension;

  ApprovalTextWriter(this.content, this.fileExtension);

  void writeToFile(String path) {
    // Writing logic here
    File(path).writeAsStringSync(content);
  }
}
