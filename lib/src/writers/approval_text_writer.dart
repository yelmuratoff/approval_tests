part of '../../approval_dart.dart';

class ApprovalTextWriter {
  final String content;
  final String fileExtension;

  ApprovalTextWriter(this.content, this.fileExtension);

  void writeToFile(String path) {
    final File file = File(path);
    if (!file.existsSync()) {
      file.createSync(recursive: true);
      file.writeAsStringSync(content);
    } else {
      file.writeAsStringSync(content);
    }
  }
}
