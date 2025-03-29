# Smart OCR

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Pub Version](https://img.shields.io/badge/pub-v1.0.0-blue)](https://pub.dev/packages/smart_ocr)

Flutter uygulamaları için hızlı ve kolay OCR ve yapay zeka destekli metin düzeltme paketi.

## Özellikler

- 📷 Kamera veya galeriden görüntü yakalama
- 🔍 Google ML Kit OCR teknolojisiyle yüksek doğrulukta metin tanıma
- 🧠 OpenAI API ile akıllı metin düzeltme
- 💾 İşlem sonuçları Rx (GetX) ile reaktif durum yönetimi
- 📱 Farklı ekran boyutlarına uyumlu kullanıcı arayüzü
- 🔄 GetX ile verimli durum yönetimi ve bağımlılık enjeksiyonu

## Mimari ve Teknolojiler

Smart OCR paketi, modern ve sürdürülebilir bir mimari ile geliştirilmiştir:

### Mimari Pattern

- **Clean Architecture**: Domain, Data ve Presentation katmanlarıyla net bir ayrım.
- **Repository Pattern**: Veri kaynaklarını soyutlamak için OcrRepository ve AiCorrectionRepository.
- **MVVM Yaklaşımı**: GetX Controller'ları ile model-view-viewmodel yaklaşımı.
- **Singleton Pattern**: Servisler ve repository'ler için tek örnek yönetimi.
- **Dependency Injection**: GetX ile bağımlılıkların enjekte edilmesi.

### Kullanılan Teknolojiler

- **GetX**: Durum yönetimi, bağımlılık enjeksiyonu ve reaktif programlama.
- **Google ML Kit**: OCR işlemleri için Android ve iOS'ta yüksek performanslı metin tanıma.
- **OpenAI API**: GPT-3.5-turbo modeli ile metin düzeltme ve iyileştirme.
- **Equatable**: Veri modelleri için eşitlik karşılaştırması.
- **Dart Streams/Rx**: Reaktif veri akışı.

### Kod Organizasyonu

```
lib/
├── core/                     # Çekirdek bileşenler
│   ├── constants/            # API, tema ve genel sabitler
│   ├── services/             # Loglama, hata yönetimi gibi ortak servisler
│   └── utils/                # Yardımcı fonksiyonlar
├── data/                     # Veri katmanı
│   ├── remote/               # Uzak veri kaynakları
│   │   ├── ai/               # OpenAI API servisleri
│   │   └── ocr/              # Google ML Kit entegrasyonu
│   └── repositories/         # Repository implementasyonları
├── domain/                   # Domain katmanı
│   ├── models/               # Veri modelleri
│   └── repositories/         # Repository arayüzleri
├── presentation/             # Sunum katmanı
│   └── controllers/          # GetX controller'ları
├── smart_ocr.dart            # Ana paket API'si
└── smart_ocr_bindings.dart   # GetX bağımlılık enjeksiyonları
```

## Kurulum

1. `pubspec.yaml` dosyanıza paketi ekleyin:

```yaml
dependencies:
  smart_ocr: ^1.0.0
```

2. Gerekli izinleri ekleyin:

### Android (AndroidManifest.xml)

```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.INTERNET" />
```

### iOS (Info.plist)

```xml
<key>NSCameraUsageDescription</key>
<string>Belgeleri taramak için kamera erişimi gerekiyor</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>Belgeleri taramak için fotoğraf kitaplığı erişimi gerekiyor</string>
```

## Hızlı Başlangıç (3 Adımda)

### 1. Smart OCR'ı başlatın:

```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_ocr/smart_ocr.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Smart OCR'ı başlat
  await SmartOcr.init();

  runApp(GetMaterialApp(home: MyApp()));
}
```

### 2. Görüntü işleme ve OCR:

```dart
// SmartOCR controller'a erişim
final controller = Get.find<SmartOcrController>();

// Görüntü işleme ve OCR
ElevatedButton(
  onPressed: () async {
    // Tek adımda görüntüden metin çıkar ve düzelt
    if (imageFile != null) {
      final resultText = await SmartOcr.processImageToText(
        imageFile: imageFile,
      );

      print('İşlem sonucu: $resultText');

      // Sonuçlara controller üzerinden erişim
      final ocrResult = controller.ocrResult.value;
      if (ocrResult != null) {
        print('OCR Sonucu: ${ocrResult.text}');
        print('Güven: ${ocrResult.confidence}%');
        print('İşlem Süresi: ${ocrResult.processTime} ms');
      }
    }
  },
  child: Text('Görüntü İşle'),
)
```

## OpenAI API Anahtarı

AI düzeltme özelliği için OpenAI API anahtarı gereklidir. API anahtarı şu şekilde eklenebilir:

```dart
// API anahtarını lib/core/constants/api_constants.dart dosyasına ekleyin
class ApiConstants {
  static const String openAiApiKey = 'YOUR_API_KEY';
  static const String openAiModelName = 'gpt-3.5-turbo';
}
```

Ya da dinamik olarak:

```dart
// Tek seferlik görüntü işleme sırasında API anahtarı sağlayın
final resultText = await SmartOcr.processImageToText(
  imageFile: imageFile,
  apiKey: 'YOUR_API_KEY',
);
```

## Örnek Uygulama

Paket içinde yer alan örnek uygulamayı inceleyerek Smart OCR'ın nasıl kullanılacağını görebilirsiniz:

```bash
# Örnek uygulamayı çalıştırın
flutter run -t example/lib/main.dart
```

Örnek uygulama şunları içerir:

- Ana ekranda OCR ve AI düzeltme özellikleri
- Kamera ve galeriden görüntü seçme
- OCR işlemi ilerleme göstergesi
- OCR sonucunu ve AI düzeltme sonucunu gösterme
- Sonuçları paylaşma ve kopyalama

## Veri Modelleri

Smart OCR paketi metin tanıma ve düzeltme için iki ana model kullanır:

### OcrResultModel

```dart
class OcrResultModel {
  final File imageFile;    // İşlenen görüntü dosyası
  final String text;       // Tanınan metin
  final double confidence; // Tanıma güveni (0-100)
  final int processTime;   // İşlem süresi (ms)
  final DateTime createdAt; // Oluşturulma tarihi
  final String language;   // Dil
}
```

### AiCorrectionModel

```dart
class AiCorrectionModel {
  final String originalText;  // Orijinal metin
  final String correctedText; // Düzeltilmiş metin
  final DateTime createdAt;   // Oluşturulma tarihi
}
```

## Sonuçları Görüntüleme

Smart OCR sonuçlarını uygulamanızda şu şekilde görüntüleyebilirsiniz:

```dart
Obx(() {
  final ocrResult = controller.ocrResult.value;
  final aiCorrectionResult = controller.aiCorrectionResult.value;

  if (ocrResult == null) {
    return const Center(child: Text('Henüz bir OCR işlemi yapılmadı'));
  }

  return Column(
    children: [
      // OCR Sonucu
      Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('OCR Sonucu', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(ocrResult.text),
              Text('Güven: ${ocrResult.confidence.toStringAsFixed(1)}%'),
              Text('İşlem Süresi: ${ocrResult.processTime} ms'),
            ],
          ),
        ),
      ),

      // AI Düzeltme Sonucu
      if (aiCorrectionResult != null) ...[
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('AI Düzeltme', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(aiCorrectionResult.correctedText),
              ],
            ),
          ),
        ),
      ],
    ],
  );
})
```

## Lisans

MIT Lisansı altında lisanslanmıştır. Detaylar için [LICENSE](LICENSE) dosyasına bakın.

## Katkıda Bulunma

Katkılarınızı memnuniyetle karşılıyoruz! GitHub sayfamızdaki issues ve pull request bölümlerini kullanabilirsiniz.
