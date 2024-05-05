import 'package:logger/logger.dart';

final _colors = {
  Level.trace: AnsiColor.fg(AnsiColor.grey(0.5)),
  Level.debug: const AnsiColor.none(),
  Level.info: const AnsiColor.fg(10),
  Level.warning: const AnsiColor.fg(208),
  Level.error: const AnsiColor.fg(196),
  Level.fatal: const AnsiColor.fg(199),
};

final class AppLogger {
  final Logger _logger;
  static final AppLogger _instance = AppLogger._internal(Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      colors: true,
      printEmojis: true,
      printTime: false,
      levelColors: _colors,
      levelEmojis: {
        Level.trace: '🔍',
        Level.debug: '🐛',
        Level.info: '🟢',
        Level.warning: '⚠️',
        Level.error: '❌',
        Level.fatal: '💀',
      },
    ),
    output: ConsoleOutput(),
  ));

  factory AppLogger() {
    return _instance;
  }

  AppLogger._internal(this._logger);

  static void log(String message) {
    _instance._logger.d(message);
  }

  static void error(String message) {
    _instance._logger.e(message);
  }

  static void warning(String message) {
    _instance._logger.w(message);
  }

  static void verbose(String message) {
    // ignore: deprecated_member_use
    _instance._logger.v(message);
  }

  static void wtf(String message) {
    // ignore: deprecated_member_use
    _instance._logger.wtf(message);
  }

  static void logError(Object error, StackTrace stackTrace) {
    _instance._logger.e(error, error: error, stackTrace: stackTrace);
  }

  static void logException(Exception exception, {StackTrace? stackTrace}) {
    _instance._logger.e(exception, error: exception, stackTrace: stackTrace);
  }

  static void good(String message) {
    _instance._logger.i(message);
  }
}
