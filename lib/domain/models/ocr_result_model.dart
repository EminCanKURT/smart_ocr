import 'dart:io';

import 'package:equatable/equatable.dart';

/// OCR sonuç modeli
class OcrResultModel extends Equatable {
  /// Constructor
  const OcrResultModel({
    required this.imageFile,
    required this.text,
    required this.confidence,
    required this.processTime,
    required this.createdAt,
    this.language = 'tr',
  });

  /// Görüntü dosyası
  final File imageFile;

  /// Tanınan metin
  final String text;

  /// Tanıma güveni (0-100)
  final double confidence;

  /// İşlem süresi (milisaniye)
  final int processTime;

  /// Oluşturulma tarihi
  final DateTime createdAt;

  /// Dil
  final String language;

  @override
  List<Object?> get props => [
        imageFile,
        text,
        confidence,
        processTime,
        createdAt,
        language,
      ];
}
