part of '../../../approval_dart.dart';

// Define constant set of colors for different log levels.
// These are the colors used by ANSI code in terminal.
const _colors = {
  Level.trace: AnsiColor.fg(196),
  Level.debug: AnsiColor.none(),
  Level.info: AnsiColor.fg(10),
  Level.warning: AnsiColor.fg(208),
  Level.error: AnsiColor.fg(196),
  Level.fatal: AnsiColor.fg(199),
};

// Define constant set of emojis for different log levels.
const _emojies = {
  Level.trace: '🔍',
  Level.debug: '🐛',
  Level.info: '🟢',
  Level.warning: '⚠️',
  Level.error: '❌',
  Level.fatal: '💀',
};

/// `AppLogger` class is a class that contains methods to log messages of different levels.
final class AppLogger {
  // Instance of logger
  final Logger _logger;

  // Singleton instance of AppLogger
  static final AppLogger _instance = AppLogger._internal(Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      colors: true,
      printEmojis: true,
      printTime: false,
      levelColors: _colors,
      levelEmojis: _emojies,
    ),
    output: ConsoleOutput(),
  ));

  // Get the singleton instance of AppLogger
  factory AppLogger() {
    return _instance;
  }

  // Private constructor to initialize the Logger
  AppLogger._internal(this._logger);

  // Method to log default messages
  static void log(String message) {
    _instance._logger.d(message);
  }

  // Method to log error messages
  static void error(String message) {
    _instance._logger.e(message);
  }

  // Method to log warning messages
  static void warning(String message) {
    _instance._logger.w(message);
  }

  // Method to log verbose messages
  static void verbose(String message) {
    // ignore: deprecated_member_use
    _instance._logger.v(message);
  }

  // Method to log severe errors, also known as WTF errors
  static void wtf(String message) {
    // ignore: deprecated_member_use
    _instance._logger.wtf(message);
  }

  // Method to log an error object with its stack trace
  static void logError(Object error, StackTrace stackTrace) {
    _instance._logger.e(error, error: error, stackTrace: stackTrace);
  }

  // Method to log exceptions
  static void logException(Exception exception, {StackTrace? stackTrace}) {
    _instance._logger.e(exception, error: exception, stackTrace: stackTrace);
  }

  // Method for logging good or successful messages
  static void good(String message) {
    _instance._logger.i(message);
  }
}
