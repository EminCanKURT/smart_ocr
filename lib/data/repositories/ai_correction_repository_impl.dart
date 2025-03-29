import 'package:smart_ocr/core/services/error_service.dart';
import 'package:smart_ocr/core/services/logger_service.dart';
import 'package:smart_ocr/data/remote/ai/open_ai_api_service.dart';
import 'package:smart_ocr/domain/models/models.dart';
import 'package:smart_ocr/domain/repositories/ai_correction_repository.dart';

/// AI düzeltme repository implementasyonu
class AiCorrectionRepositoryImpl implements AiCorrectionRepository {
  /// Factory constructor
  factory AiCorrectionRepositoryImpl() => _instance;

  /// Internal constructor
  AiCorrectionRepositoryImpl._internal();

  /// Singleton instance
  static final AiCorrectionRepositoryImpl _instance =
      AiCorrectionRepositoryImpl._internal();

  /// Logger servisi
  final _logger = LoggerService();

  /// Hata servisi
  final _errorService = ErrorService();

  /// OpenAI API servisi
  final _openAiService = OpenAiApiService();

  @override
  Future<AiCorrectionModel> correctText({
    required String text,
    String? apiKey,
  }) async {
    try {
      _logger.i('AI düzeltme işlemi başlatılıyor');

      // OpenAI API ile metin düzeltme
      final result = await _openAiService.correctText(
        text: text,
        apiKey: apiKey,
      );

      _logger.i('AI düzeltme işlemi tamamlandı');

      return result;
    } catch (e, stackTrace) {
      final error = _errorService.createAiCorrectionError(
        message: 'AI düzeltme işlemi sırasında hata oluştu: $e',
        stackTrace: stackTrace,
      );
      _logger.e(error.toString(), e, stackTrace);
      throw error;
    }
  }
}
