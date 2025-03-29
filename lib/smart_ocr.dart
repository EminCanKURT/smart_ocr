import 'dart:io';

import 'package:get/get.dart';
import 'package:smart_ocr/core/services/logger_service.dart';
import 'package:smart_ocr/presentation/controllers/smart_ocr_controller.dart';
import 'package:smart_ocr/smart_ocr_bindings.dart';

/// SmartOCR paketi
class SmartOcr {
  /// Constructor
  const SmartOcr._();

  /// Logger servisi
  static final _logger = LoggerService();

  /// SmartOCR paketini başlat
  /// Package başlatılırken çağrılmalıdır.
  static Future<void> init() async {
    try {
      _logger.i('SmartOCR paketi başlatılıyor');

      // Bağımlılıkları enjekte et
      SmartOcrBindings().dependencies();

      _logger.i('SmartOCR paketi başlatıldı');
    } catch (e, stackTrace) {
      _logger.e('SmartOCR paketi başlatılırken hata oluştu', e, stackTrace);
      rethrow;
    }
  }

  /// Verilen görüntüden OCR ile metin çıkarır ve AI ile düzeltilmiş halini döndürür
  /// [imageFile] OCR yapılacak görüntü dosyası
  /// [apiKey] OpenAI API anahtarı (opsiyonel)
  /// [saveResult] Sonucun veritabanına kaydedilip kaydedilmeyeceği
  /// return Düzeltilmiş metin
  static Future<String> processImageToText({
    required File imageFile,
    String? apiKey,
    bool saveResult = false,
  }) async {
    try {
      final controller = Get.find<SmartOcrController>();
      return await controller.processImageToText(
        imageFile: imageFile,
        apiKey: apiKey,
        saveResult: saveResult,
      );
    } catch (e, stackTrace) {
      _logger.e('Görüntü işleme hatası', e, stackTrace);
      rethrow;
    }
  }
}
