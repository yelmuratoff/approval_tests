part of '../../../approval_dart.dart';

/// `AppLogger` is a class that provides methods to log messages with different log levels.
final class AppLogger {
  // Private property holding the instance of Logger
  final Logger _logger;

  // Singleton instance of AppLogger
  static final AppLogger _instance = AppLogger._internal(Logger(
    printer: AppPrettyPrinter(
      methodCount: 0,
      colors: true,
      printEmojis: true,
      printTime: false,
      levelColors: _colors,
      levelEmojis: _emojies,
    ),
    output: ConsoleOutput(),
  ));

  // Factory constructor returning the Singleton instance
  factory AppLogger() {
    return _instance;
  }

  // Private internal constructor for initializing the Logger instance
  AppLogger._internal(this._logger);

  // Define constant title with ANSI color codes.
  static const _approvalTitle =
      "\u001b[38;2;118;172;205mApp\u001b[38;2;186;207;113mroval\u001b[38;2;243;185;96mTests\u001b[0m";

// Define mapping of log levels to their corresponding colors.
  static const _colors = {
    Level.trace: AnsiColor.fg(196),
    Level.debug: AnsiColor.none(),
    Level.info: AnsiColor.fg(10),
    Level.warning: AnsiColor.fg(208),
    Level.error: AnsiColor.fg(196),
    Level.fatal: AnsiColor.fg(199),
  };

// Define mapping of log levels to their corresponding emojis.
  static const _emojies = {
    Level.trace: '🔍 $_approvalTitle',
    Level.debug: '🐛 $_approvalTitle',
    Level.info: '🟢 $_approvalTitle',
    Level.warning: '⚠️ $_approvalTitle',
    Level.error: '❌ $_approvalTitle',
    Level.fatal: '💀 $_approvalTitle',
  };

  // Helper method to apply color to a log message based on log level
  static String _colorMessage(Level level, String message) {
    return _colors[level]!("| $message");
  }

  // Logging methods that use the helper method to colorize messages.
  static void log(String message) =>
      _instance._logger.d(_colorMessage(Level.info, message));
  static void error(String message) =>
      _instance._logger.e(_colorMessage(Level.error, message));
  static void warning(String message) =>
      _instance._logger.w(_colorMessage(Level.warning, message));
  static void trace(String message) =>
      _instance._logger.t(_colorMessage(Level.trace, message));
  static void fatal(String message) =>
      _instance._logger.f(_colorMessage(Level.fatal, message));
  static void good(String message) =>
      _instance._logger.i(_colorMessage(Level.info, message));

  static void exception(Exception exception, {StackTrace? stackTrace}) {
    final message = exception.toString();
    _instance._logger
        .e(_colorMessage(Level.error, message), stackTrace: stackTrace);
  }
}
