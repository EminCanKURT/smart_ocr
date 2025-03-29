import 'dart:io';

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:smart_ocr/core/services/logger_service.dart';
import 'package:smart_ocr/domain/models/models.dart';

/// ML Kit OCR servisi
class MlKitOcrService {
  /// Factory constructor
  factory MlKitOcrService() => _instance;

  /// Internal constructor
  MlKitOcrService._internal() {
    _textRecognizer = TextRecognizer();
  }

  /// Singleton instance
  static final MlKitOcrService _instance = MlKitOcrService._internal();

  /// Logger servisi
  final _logger = LoggerService();

  /// ML Kit text recognizer
  late final TextRecognizer _textRecognizer;

  /// Görüntüden metin tanıma
  ///
  /// [imageFile] Görüntü dosyası
  /// [language] Tanıma dili (ML Kit'te dil seçimi yok, bu parametre uyumluluk için tutuldu)
  /// Returns OCR sonucu
  Future<OcrResultModel> recognizeText({
    required File imageFile,
    String language = 'tr',
  }) async {
    try {
      _logger.i('OCR işlemi başlatılıyor: ${imageFile.path}');
      final startTime = DateTime.now().millisecondsSinceEpoch;

      // ML Kit ile görüntüyü işle
      final inputImage = InputImage.fromFile(imageFile);
      final recognizedText = await _textRecognizer.processImage(inputImage);

      // İşlem süresini hesapla
      final endTime = DateTime.now().millisecondsSinceEpoch;
      final processTime = endTime - startTime;

      // Güven skorunu hesapla
      final confidence = _calculateConfidence(recognizedText);

      _logger.i('OCR işlemi tamamlandı: ${processTime}ms, güven: $confidence');

      // OCR sonucunu oluştur
      return OcrResultModel(
        imageFile: imageFile,
        text: recognizedText.text,
        confidence: confidence,
        processTime: processTime,
        language: language,
        createdAt: DateTime.now(),
      );
    } catch (e, stackTrace) {
      _logger.e('OCR işlemi sırasında hata oluştu', e, stackTrace);
      rethrow;
    }
  }

  /// Güven skorunu hesapla
  ///
  /// [recognizedText] Tanınan metin
  /// Returns Güven skoru (0-100)
  double _calculateConfidence(RecognizedText recognizedText) {
    if (recognizedText.text.isEmpty) {
      return 0;
    }

    // ML Kit doğrudan güven skoru vermez, bu yüzden blok sayısı ve metin uzunluğuna göre tahmini bir değer hesaplayalım
    final textLength = recognizedText.text.length;
    final blockCount = recognizedText.blocks.length;
    final wordCount = recognizedText.text.split(' ').length;

    if (textLength == 0 || blockCount == 0) {
      return 0;
    }

    // Metin uzunluğu, blok sayısı ve kelime sayısına göre basit bir güven skoru hesapla
    final normalizedLength =
        textLength / 100.0; // Metin uzunluğunu normalize et
    final normalizedBlockCount = blockCount / 5.0; // Blok sayısını normalize et
    final normalizedWordCount =
        wordCount / 20.0; // Kelime sayısını normalize et

    // 0-100 aralığında bir güven skoru hesapla
    final confidence =
        (normalizedLength + normalizedBlockCount + normalizedWordCount) * 30.0;

    // Maksimum 100 olacak şekilde sınırla
    return confidence > 100.0 ? 100.0 : confidence;
  }

  /// Servisi kapat
  void dispose() {
    _textRecognizer.close();
  }
}
