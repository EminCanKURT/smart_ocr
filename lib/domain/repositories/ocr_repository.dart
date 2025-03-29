// ignore_for_file: one_member_abstracts

import 'dart:io';

import 'package:smart_ocr/domain/models/models.dart';

/// OCR repository arayüzü
abstract class OcrRepository {
  /// Görüntüden metin tanıma
  ///
  /// [imageFile] Görüntü dosyası
  /// [language] Tanıma dili (varsayılan: tr)
  /// Returns OCR sonucu
  Future<OcrResultModel> recognizeText({
    required File imageFile,
    String language = 'tr',
  });
}
