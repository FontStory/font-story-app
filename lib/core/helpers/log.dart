import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class LogManager {
  LogManager._();

  static final LogManager _instance = LogManager._();

  static LogManager get instance => _instance;

  late final Logger _logger;

  void initialize() {
    _logger = Logger(
      printer: PrettyPrinter(
        methodCount: 0, // Number of method calls to be displayed
        errorMethodCount: 0, // Number of method calls if stacktrace is provided
        lineLength: 120, // Width of the output
        colors: true, // Colorful log messages
        printEmojis: true, // Print an emoji for each log message
        noBoxingByDefault: true,
      ),
      // Only log in debug mode
      filter: kDebugMode ? DevelopmentFilter() : ProductionFilter(),
    );
  }

  /// Log a message at level [Level.debug].
  void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  /// Log a message at level [Level.info].
  void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  /// Log a message at level [Level.warning].
  void w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  /// Log a message at level [Level.error].
  void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
}
