/// Örnek uygulama rota sabitleri
class ExampleRouteConstants {
  /// Factory constructor
  factory ExampleRouteConstants() => _instance;

  /// Internal constructor
  ExampleRouteConstants._internal();

  /// Singleton instance
  static final ExampleRouteConstants _instance =
      ExampleRouteConstants._internal();

  /// Ana ekran
  static const String home = '/';

  /// OCR işlemi ekranı
  static const String ocrProcess = '/example_ocr_process';

  /// AI düzeltme ekranı
  static const String aiCorrection = '/example_ai_correction';

  /// Sonuç ekranı
  static const String result = '/example_result';
}
