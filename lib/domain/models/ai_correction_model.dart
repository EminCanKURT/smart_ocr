import 'package:equatable/equatable.dart';

/// AI düzeltme sonuç modeli
class AiCorrectionModel extends Equatable {
  /// Constructor
  const AiCorrectionModel({
    required this.originalText,
    required this.correctedText,
    required this.createdAt,
  });

  /// Orijinal metin
  final String originalText;

  /// Düzeltilmiş metin
  final String correctedText;

  /// Oluşturulma tarihi
  final DateTime createdAt;

  @override
  List<Object?> get props => [originalText, correctedText, createdAt];
}
