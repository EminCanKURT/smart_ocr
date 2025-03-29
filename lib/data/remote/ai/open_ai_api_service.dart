import 'package:openai_dart/openai_dart.dart';
import 'package:smart_ocr/core/constants/api_constants.dart';
import 'package:smart_ocr/core/services/logger_service.dart';
import 'package:smart_ocr/domain/models/models.dart';

/// OpenAI API servisi
class OpenAiApiService {
  /// Factory constructor
  factory OpenAiApiService() => _instance;

  /// Internal constructor
  OpenAiApiService._internal();

  /// Singleton instance
  static final OpenAiApiService _instance = OpenAiApiService._internal();

  /// Logger servisi
  final _logger = LoggerService();

  /// OpenAI istemcisi
  OpenAIClient? _openAiClient;

  /// OpenAI istemcisini al
  OpenAIClient _getClient(String apiKey) {
    _openAiClient ??= OpenAIClient(apiKey: apiKey);
    return _openAiClient!;
  }

  /// OpenAI API ile metin düzeltme
  ///
  /// [text] düzeltilecek metin
  /// [apiKey] opsiyonel API anahtarı
  Future<AiCorrectionModel> correctText({
    required String text,
    String? apiKey,
  }) async {
    try {
      _logger.i('OpenAI API ile metin düzeltme işlemi başlatılıyor');

      // API anahtarını kontrol et
      final effectiveApiKey = apiKey ?? ApiConstants.openAiApiKey;
      if (effectiveApiKey.isEmpty) {
        // API anahtarı yoksa simülasyon yap
        return _simulateCorrection(text);
      }

      // OpenAI istemcisini al
      final client = _getClient(effectiveApiKey);

      // Prompt oluştur
      final prompt = _createPrompt(text);

      // API isteği gönder
      final chatCompletion = await client.createChatCompletion(
        request: CreateChatCompletionRequest(
          model:
              const ChatCompletionModel.modelId(ApiConstants.openAiModelName),
          messages: [
            ChatCompletionMessage.user(
              content: ChatCompletionUserMessageContent.string(prompt),
            ),
          ],
          temperature: 0.2,
          maxTokens: 1000,
        ),
      );

      // Yanıtı kontrol et
      if (chatCompletion.choices.isEmpty) {
        throw Exception('OpenAI API yanıtı boş');
      }

      // Yanıtı ayrıştır
      final content = chatCompletion.choices.first.message.content;
      if (content == null) {
        throw Exception('OpenAI API yanıtı boş');
      }

      // OpenAI yanıtını logla
      _logger
        ..i(
          'OpenAI API isteği yapıldı. Model: ${ApiConstants.openAiModelName}',
        )
        ..i('OpenAI API yanıtı: $content')
        ..i('OpenAI API yanıtı - Tüm detaylar: $chatCompletion');

      // Düzeltilmiş metni çıkar
      final correctedText = _extractCorrectedText(content);

      _logger.i('OpenAI API ile metin düzeltme işlemi tamamlandı');

      // Sonuç modelini oluştur
      return AiCorrectionModel(
        originalText: text,
        correctedText: correctedText,
        createdAt: DateTime.now(),
      );
    } catch (e, stackTrace) {
      _logger
          .w('OpenAI API hatası, simülasyon moduna geçiliyor: $e $stackTrace');
      // Hata durumunda simülasyon yap
      return _simulateCorrection(text);
    }
  }

  /// Metin düzeltme simülasyonu yap
  ///
  /// [text] düzeltilecek metin
  Future<AiCorrectionModel> _simulateCorrection(String text) async {
    _logger.i('Metin düzeltme simülasyonu yapılıyor');

    // 1-2 saniye bekleyerek API çağrısını simüle et
    await Future<void>.delayed(const Duration(seconds: 1));

    // Basit düzeltmeler yap
    var correctedText = text;

    // Yaygın OCR hatalarını düzelt
    correctedText = correctedText
        .replaceAll('0', 'O')
        .replaceAll('1', 'I')
        .replaceAll('rn', 'm')
        .replaceAll('cl', 'd')
        .replaceAll('vv', 'w');

    // Kelime sonlarındaki noktalama işaretlerini düzelt
    correctedText = correctedText
        .replaceAll(' ,', ',')
        .replaceAll(' .', '.')
        .replaceAll(' ;', ';')
        .replaceAll(' :', ':');

    // Gereksiz boşlukları düzelt
    correctedText = correctedText.replaceAll('  ', ' ').trim();

    _logger.i('Metin düzeltme simülasyonu tamamlandı');

    return AiCorrectionModel(
      originalText: text,
      correctedText: correctedText,
      createdAt: DateTime.now(),
    );
  }

  /// Prompt oluştur
  ///
  /// [text] düzeltilecek metin
  String _createPrompt(String text) {
    return '''
Sen bir OCR (Optik Karakter Tanıma) sonuçlarını düzelten bir asistansın. 
Aşağıdaki metni, OCR tarafından yanlış tanınmış olabilecek karakterleri, kelimeleri ve cümleleri düzelterek anlamlı hale getir.
Metin içindeki yazım hatalarını, eksik veya fazla karakterleri, yanlış tanınan harfleri düzelt.
Sadece düzeltilmiş metni döndür, açıklama yapma.

OCR Metni:
$text

Düzeltilmiş Metin:
''';
  }

  /// Düzeltilmiş metni çıkar
  ///
  /// [content] API yanıtı
  String _extractCorrectedText(String content) {
    // API yanıtından düzeltilmiş metni çıkar
    // Bazen API yanıtı fazladan açıklamalar içerebilir
    // Bu durumda sadece düzeltilmiş metni almak için basit bir işlem yapıyoruz

    // Eğer yanıt "Düzeltilmiş Metin:" içeriyorsa, bu kısmı al
    if (content.contains('Düzeltilmiş Metin:')) {
      final parts = content.split('Düzeltilmiş Metin:');
      return parts[1].trim();
    }

    return content.trim();
  }
}
