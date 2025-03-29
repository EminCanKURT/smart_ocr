import 'dart:io';

import 'package:get/get.dart';
import 'package:smart_ocr/core/services/error_service.dart';
import 'package:smart_ocr/core/services/logger_service.dart';
import 'package:smart_ocr/domain/models/models.dart';
import 'package:smart_ocr/domain/repositories/ai_correction_repository.dart';
import 'package:smart_ocr/domain/repositories/ocr_repository.dart';

/// SmartOCR işlemlerini yöneten controller
class SmartOcrController extends GetxController {
  /// Constructor
  SmartOcrController({
    required OcrRepository ocrRepository,
    required AiCorrectionRepository aiCorrectionRepository,
  })  : _ocrRepository = ocrRepository,
        _aiCorrectionRepository = aiCorrectionRepository;

  /// OCR repository
  final OcrRepository _ocrRepository;

  /// AI düzeltme repository
  final AiCorrectionRepository _aiCorrectionRepository;

  /// Logger servisi
  final _logger = LoggerService();

  /// Hata servisi
  final _errorService = ErrorService();

  /// Yükleniyor durumu
  final RxBool isLoading = false.obs;

  /// OCR işlemi yükleniyor durumu
  final RxBool isOcrLoading = false.obs;

  /// AI düzeltme işlemi yükleniyor durumu
  final RxBool isAiCorrectionLoading = false.obs;

  /// Hata durumu
  final Rx<ErrorModel?> error = Rx<ErrorModel?>(null);

  /// Seçilen görüntü
  final Rx<File?> selectedImage = Rx<File?>(null);

  /// OCR sonucu
  final Rx<OcrResultModel?> ocrResult = Rx<OcrResultModel?>(null);

  /// AI düzeltme sonucu
  final Rx<AiCorrectionModel?> aiCorrectionResult =
      Rx<AiCorrectionModel?>(null);

  /// Verilen görüntüden metin çıkarıp AI ile düzelterek string döndürür
  /// [imageFile] OCR yapılacak görüntü dosyası
  /// [apiKey] OpenAI API anahtarı (isteğe bağlı)
  /// [saveResult] Sonucun veritabanına kaydedilip kaydedilmeyeceği
  /// return Düzeltilmiş metin (String)
  Future<String> processImageToText({
    required File imageFile,
    String? apiKey,
    bool saveResult = false,
  }) async {
    try {
      // Yükleniyor durumunu ayarla
      isLoading.value = true;
      error.value = null;

      // Görüntüyü ayarla
      selectedImage.value = imageFile;

      // OCR işlemini başlat
      isOcrLoading.value = true;
      final ocrRes = await _ocrRepository.recognizeText(
        imageFile: imageFile,
      );
      ocrResult.value = ocrRes;
      isOcrLoading.value = false;

      // AI düzeltme işlemini başlat
      isAiCorrectionLoading.value = true;
      final aiRes = await _aiCorrectionRepository.correctText(
        text: ocrRes.text,
        apiKey: apiKey,
      );
      aiCorrectionResult.value = aiRes;
      isAiCorrectionLoading.value = false;

      // Düzeltilmiş metni döndür
      return aiRes.correctedText;
    } catch (e, stackTrace) {
      _handleError(e, stackTrace);
      // Hata durumunda boş string döndür
      return '';
    } finally {
      isOcrLoading.value = false;
      isAiCorrectionLoading.value = false;
      isLoading.value = false;
    }
  }

  /// Hata yönetimi
  void _handleError(dynamic e, StackTrace stackTrace) {
    if (e is ErrorModel) {
      error.value = e;
    } else {
      error.value = _errorService.createUnexpectedError(
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
    _logger.e(error.value.toString(), e, stackTrace);
  }
}
