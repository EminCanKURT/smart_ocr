// ignore_for_file: one_member_abstracts

import 'package:smart_ocr/domain/models/models.dart';

/// AI düzeltme repository arayüzü
abstract class AiCorrectionRepository {
  /// Metni düzelt
  ///
  /// [text] Düzeltilecek metin
  /// [apiKey] API anahtarı (opsiyonel)
  /// Returns AI düzeltme sonucu
  Future<AiCorrectionModel> correctText({
    required String text,
    String? apiKey,
  });
}
