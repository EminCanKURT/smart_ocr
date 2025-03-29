import 'package:equatable/equatable.dart';

/// Hata türleri
enum ErrorType {
  /// Ağ hatası
  network,

  /// Sunucu hatası
  server,

  /// Veri hatası
  data,

  /// İzin hatası
  permission,

  /// Beklenmeyen hata
  unexpected,
}

/// Hata modeli
class ErrorModel extends Equatable implements Exception {
  /// Constructor
  const ErrorModel({
    required this.type,
    required this.message,
    required this.stackTrace,
    this.code,
  });

  /// JSON'dan model oluştur
  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      type: ErrorType.values[json['type'] as int],
      message: json['message'] as String,
      stackTrace: StackTrace.fromString(json['stackTrace'] as String? ?? ''),
      code: json['code'] as String?,
    );
  }

  /// Hata türü
  final ErrorType type;

  /// Hata mesajı
  final String message;

  /// Hata kodu
  final String? code;

  /// Hata stack trace
  final StackTrace stackTrace;

  @override
  List<Object?> get props => [type, message, code, stackTrace];

  @override
  String toString() {
    return 'ErrorModel(type: $type, message: $message, code: $code)';
  }

  /// Modeli JSON'a dönüştür
  Map<String, dynamic> toJson() {
    return {
      'type': type.index,
      'message': message,
      'stackTrace': stackTrace.toString(),
      'code': code,
    };
  }
}
