import 'package:smart_ocr/core/services/logger_service.dart';
import 'package:smart_ocr/domain/models/error_model.dart';

/// Hata servisi
class ErrorService {
  /// Factory constructor
  factory ErrorService() => _instance;

  /// Internal constructor
  ErrorService._internal();

  /// Singleton instance
  static final ErrorService _instance = ErrorService._internal();

  /// Logger servisi
  final _logger = LoggerService();

  /// Ağ hatası oluştur
  ErrorModel createNetworkError({
    required String message,
    required StackTrace stackTrace,
    String? code,
  }) {
    return ErrorModel(
      type: ErrorType.network,
      message: message,
      stackTrace: stackTrace,
      code: code,
    );
  }

  /// Sunucu hatası oluştur
  ErrorModel createServerError({
    required String message,
    required StackTrace stackTrace,
    String? code,
  }) {
    return ErrorModel(
      type: ErrorType.server,
      message: message,
      stackTrace: stackTrace,
      code: code,
    );
  }

  /// Veri hatası oluştur
  ErrorModel createDataError({
    required String message,
    required StackTrace stackTrace,
    String? code,
  }) {
    return ErrorModel(
      type: ErrorType.data,
      message: message,
      stackTrace: stackTrace,
      code: code,
    );
  }

  /// İzin hatası oluştur
  ErrorModel createPermissionError({
    required String message,
    required StackTrace stackTrace,
    String? code,
  }) {
    return ErrorModel(
      type: ErrorType.permission,
      message: message,
      stackTrace: stackTrace,
      code: code,
    );
  }

  /// OCR hatası oluştur
  ErrorModel createOcrError({
    required String message,
    required StackTrace stackTrace,
    String? code,
  }) {
    return ErrorModel(
      type: ErrorType.unexpected,
      message: message,
      stackTrace: stackTrace,
      code: code ?? 'OCR_ERROR',
    );
  }

  /// AI düzeltme hatası oluştur
  ErrorModel createAiCorrectionError({
    required String message,
    required StackTrace stackTrace,
    String? code,
  }) {
    return ErrorModel(
      type: ErrorType.unexpected,
      message: message,
      stackTrace: stackTrace,
      code: code ?? 'AI_CORRECTION_ERROR',
    );
  }

  /// Beklenmeyen hata oluştur
  ErrorModel createUnexpectedError({
    required String message,
    required StackTrace stackTrace,
    String? code,
  }) {
    return ErrorModel(
      type: ErrorType.unexpected,
      message: message,
      stackTrace: stackTrace,
      code: code,
    );
  }

  /// Hata işle
  void handleError(dynamic error, [StackTrace? stackTrace]) {
    if (error is ErrorModel) {
      _logger.e(error.toString(), error, stackTrace);
      return;
    }

    final appError = createUnexpectedError(
      message: error.toString(),
      stackTrace: stackTrace ?? StackTrace.current,
    );

    _logger.e(appError.toString(), error, stackTrace);
  }
}
