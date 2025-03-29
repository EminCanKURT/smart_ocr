/// API ile ilgili sabitler
class ApiConstants {
  /// Factory constructor
  factory ApiConstants() => _instance;

  /// Internal constructor
  ApiConstants._internal();

  /// Singleton instance
  static final ApiConstants _instance = ApiConstants._internal();

  /// API istek zaman aşımı (milisaniye)
  static const int requestTimeout = 30000;

  /// API yeniden deneme sayısı
  static const int maxRetries = 3;

  /// API yeniden deneme bekleme süresi (milisaniye)
  static const int retryDelay = 1000;

  /// API istek başlıkları
  static Map<String, String> get headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  /// API istek başlıkları (API anahtarı ile)
  static Map<String, String> headersWithApiKey(String apiKey) => {
        ...headers,
        'Authorization': 'Bearer $apiKey',
      };

  /// OpenAI API URL'si
  static const String openAiApiUrl =
      'https://api.openai.com/v1/chat/completions';

  /// OpenAI model adı (GPT-3.5 Turbo)
  static const String openAiModelName = 'gpt-3.5-turbo';

  /// OpenAI API anahtarı
  ///
  /// Not: Gerçek uygulamada bu değer güvenli bir şekilde saklanmalıdır
  /// Örneğin: .env dosyası, Flutter Secure Storage, vb.
  static const String openAiApiKey = '';
}
