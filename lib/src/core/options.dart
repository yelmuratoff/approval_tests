class Options {
  final bool isScrub;
  final String fileExtensionWithoutDot;

  const Options({this.isScrub = false, this.fileExtensionWithoutDot = 'txt'});

  String scrub(String input) => isScrub ? _scrubInput(input) : input;

  String _scrubInput(String input) {
    return input.replaceAll(RegExp(r'\s+'), ' ').trim();
  }
}
