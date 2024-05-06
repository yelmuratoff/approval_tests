part of '../../../approval_dart.dart';

/// `AppLogger` is a class that provides methods to log messages with different log levels.
final class AppLogger {
  // Private property holding the instance of Logger
  final Talker _logger;

  // Singleton instance of AppLogger
  static final AppLogger _instance = AppLogger._internal(
    Talker(
      settings: TalkerSettings(
        titles: _defaultTitles,
      ),
    ),
  );

  // Factory constructor returning the Singleton instance
  factory AppLogger() {
    return _instance;
  }

  // Private internal constructor for initializing the Logger instance
  AppLogger._internal(this._logger);

  // Define constant title with ANSI color codes.
  static const _approvalTitle = "ApprovalTests";

  // Define default titles for different log types.
  static const _defaultTitles = {
    TalkerLogType.critical: '💀 $_approvalTitle',
    TalkerLogType.warning: '⚠️ $_approvalTitle',
    TalkerLogType.verbose: '🐛 $_approvalTitle',
    TalkerLogType.info: '🔍 $_approvalTitle',
    TalkerLogType.debug: '🐛 $_approvalTitle',
    TalkerLogType.error: '❌ $_approvalTitle',
    TalkerLogType.exception: '❌ $_approvalTitle',
  };

  /// `log` method to log messages with debug log level.
  static void log(String message) => _instance._logger.debug(message);

  /// `info` method to log messages with success log level.
  static void success(String message) => _instance._logger.logTyped(_SuccessLog(message));

  /// `error` method to log messages with error log level.
  static void error(String message) => _instance._logger.error(message);

  /// `exception` method to handle exceptions and log them with error log level.
  static void exception(Object exception, {StackTrace? stackTrace}) {
    final message = exception.toString();
    _instance._logger.handle(
      exception,
      stackTrace,
      message,
    );
  }
}

/// `_SuccessLog` is a class that extends `TalkerLog` to provide success logs.
class _SuccessLog extends TalkerLog {
  _SuccessLog(String super.message);

  /// Your custom log title
  @override
  String get title => '🟢 ${AppLogger._approvalTitle}';

  /// Your custom log color
  @override
  AnsiPen get pen => AnsiPen()..xterm(121);
}
