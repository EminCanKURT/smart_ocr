/// Uygulama genelinde kullanılan sabitler
class AppConstants {
  /// Factory constructor
  factory AppConstants() => _instance;

  /// Internal constructor
  AppConstants._internal();

  /// Singleton instance
  static final AppConstants _instance = AppConstants._internal();

  /// Uygulama adı
  static const String appName = 'Smart OCR';

  /// Uygulama versiyonu
  static const String appVersion = '0.0.1';

  /// Uygulama açıklaması
  static const String appDescription =
      'Flutter paketi olarak geliştirilmiş, OCR ve AI düzeltme özelliklerine sahip akıllı metin tanıma modülü.';

  /// Uygulama yazarı
  static const String appAuthor = 'Your Name';

  /// Uygulama web sitesi
  static const String appWebsite = 'https://github.com/yourusername/smart_ocr';

  /// Uygulama lisansı
  static const String appLicense = 'MIT';

  /// Desteklenen diller
  static const List<String> supportedLanguages = ['tr', 'en'];

  /// Varsayılan dil
  static const String defaultLanguage = 'tr';

  /// Temel hata mesajları
  static const String errorGeneric = 'Bir hata oluştu. Lütfen tekrar deneyin.';
  static const String errorNoInternet =
      'İnternet bağlantısı bulunamadı. Lütfen bağlantınızı kontrol edin.';
  static const String errorOcrFailed =
      'Metin tanıma işlemi başarısız oldu. Lütfen tekrar deneyin.';
  static const String errorAiCorrectionFailed =
      'AI düzeltme işlemi başarısız oldu. Lütfen tekrar deneyin.';
}
