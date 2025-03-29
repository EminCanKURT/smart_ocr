import 'dart:io';

import 'package:smart_ocr/core/services/error_service.dart';
import 'package:smart_ocr/core/services/logger_service.dart';
import 'package:smart_ocr/data/remote/ocr/tesseract_ocr_service.dart';
import 'package:smart_ocr/domain/models/models.dart';
import 'package:smart_ocr/domain/repositories/ocr_repository.dart';

/// OCR repository implementasyonu
class OcrRepositoryImpl implements OcrRepository {
  /// Factory constructor
  factory OcrRepositoryImpl() => _instance;

  /// Internal constructor
  OcrRepositoryImpl._internal();

  /// Singleton instance
  static final OcrRepositoryImpl _instance = OcrRepositoryImpl._internal();

  /// Logger servisi
  final _logger = LoggerService();

  /// Hata servisi
  final _errorService = ErrorService();

  /// ML Kit OCR servisi
  final _mlKitService = MlKitOcrService();

  @override
  Future<OcrResultModel> recognizeText({
    required File imageFile,
    String language = 'tr',
  }) async {
    try {
      _logger.i('OCR işlemi başlatılıyor: ${imageFile.path}');

      // ML Kit OCR ile metin tanıma
      final result = await _mlKitService.recognizeText(
        imageFile: imageFile,
        language: language,
      );

      _logger.i('OCR işlemi tamamlandı');

      return result;
    } catch (e, stackTrace) {
      final error = _errorService.createOcrError(
        message: 'OCR işlemi sırasında hata oluştu: $e',
        stackTrace: stackTrace,
      );
      _logger.e(error.toString(), e, stackTrace);
      throw error;
    }
  }
}
