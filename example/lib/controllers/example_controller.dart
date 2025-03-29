import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_ocr/domain/models/models.dart';
import 'package:smart_ocr/presentation/controllers/smart_ocr_controller.dart';
import 'package:smart_ocr/smart_ocr.dart';

/// Örnek uygulama controller'ı
class ExampleController extends GetxController {
  /// Constructor
  ExampleController({required this.smartOcrController});

  /// SmartOCR controller'ı
  final SmartOcrController smartOcrController;

  /// Seçilen görüntü
  final selectedImage = Rx<File?>(null);

  /// OCR sonucu
  final ocrResult = Rx<OcrResultModel?>(null);

  /// AI düzeltme sonucu
  final aiCorrectionResult = Rx<AiCorrectionModel?>(null);

  /// Yükleniyor durumu
  final isLoading = false.obs;

  /// OCR işlemi yükleniyor durumu
  final isOcrProcessing = false.obs;

  /// OCR ilerleme durumu
  final ocrProgress = 0.0.obs;

  /// OCR durum mesajı
  final ocrStatusMessage = 'OCR işlemi başlatılıyor...'.obs;

  /// AI düzeltme işlemi yükleniyor durumu
  final isAiCorrectionProcessing = false.obs;

  /// AI düzeltme ilerleme durumu
  final aiCorrectionProgress = 0.0.obs;

  /// AI düzeltme durum mesajı
  final aiCorrectionStatusMessage = 'AI düzeltme işlemi başlatılıyor...'.obs;

  /// Hata mesajı
  final errorMessage = Rx<String?>(null);

  /// Görüntü seç
  Future<void> pickImage(ImageSource source) async {
    try {
      isLoading.value = true;
      errorMessage.value = null;

      // Görüntü seçici - iOS/Android için optimize edilmiş
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1200,
        maxHeight: 1200,
        preferredCameraDevice: CameraDevice.rear,
      );

      if (pickedFile != null) {
        selectedImage.value = File(pickedFile.path);
        // SmartOCR controller'a da görüntüyü ayarla
        smartOcrController.selectedImage.value = selectedImage.value;
      }
    } catch (e) {
      errorMessage.value = 'Görüntü seçme işlemi başarısız oldu: $e';
    } finally {
      isLoading.value = false;
    }
  }

  /// OCR işlemini başlat
  Future<void> startOcrProcess() async {
    if (selectedImage.value == null) {
      errorMessage.value = 'Lütfen önce bir görüntü seçin.';
      return;
    }

    try {
      isOcrProcessing.value = true;
      errorMessage.value = null;
      ocrProgress.value = 0.0;
      ocrStatusMessage.value = 'Görüntü analiz ediliyor...';

      // İlerleme simülasyonu
      await _simulateProgress(ocrProgress);
      ocrStatusMessage.value = 'Metin tanıma işlemi tamamlanıyor...';

      // OCR işlemini direkt olarak tamamla (burada tek adım işlemi kullanılıyor aslında)
      await processImageWithOneStep();

      ocrProgress.value = 1.0;
      ocrStatusMessage.value = 'OCR işlemi tamamlandı.';
      isOcrProcessing.value = false;
    } catch (e) {
      errorMessage.value = 'OCR işlemi başarısız oldu: $e';
      isOcrProcessing.value = false;
    }
  }

  /// AI düzeltme işlemini başlat
  Future<void> startAiCorrectionProcess() async {
    if (ocrResult.value == null) {
      errorMessage.value = 'Lütfen önce OCR işlemini tamamlayın.';
      return;
    }

    try {
      isAiCorrectionProcessing.value = true;
      errorMessage.value = null;
      aiCorrectionProgress.value = 0.0;
      aiCorrectionStatusMessage.value = 'AI modeli hazırlanıyor...';

      // İlerleme simülasyonu
      await _simulateProgress(aiCorrectionProgress);
      aiCorrectionStatusMessage.value = 'Metin düzeltiliyor...';

      // AI düzeltme işlemi zaten tamamlanmış durumda, direkt alıyoruz
      aiCorrectionProgress.value = 1.0;
      aiCorrectionStatusMessage.value = 'AI düzeltme işlemi tamamlandı.';
      isAiCorrectionProcessing.value = false;
    } catch (e) {
      errorMessage.value = 'AI düzeltme işlemi başarısız oldu: $e';
      isAiCorrectionProcessing.value = false;
    }
  }

  /// İlerleme simülasyonu
  Future<void> _simulateProgress(RxDouble progressValue) async {
    for (var i = 0; i < 90; i += 10) {
      await Future.delayed(const Duration(milliseconds: 100));
      progressValue.value = i / 100;
    }
  }

  /// Tek adımda görüntüden metin çıkar ve düzelt
  /// SmartOcr.processImageToText kullanımının örneği
  Future<String> processImageWithOneStep() async {
    if (selectedImage.value == null) {
      errorMessage.value = 'Lütfen önce bir görüntü seçin.';
      return '';
    }

    try {
      isLoading.value = true;
      errorMessage.value = null;

      // Tek adımda görüntüden metin çıkar ve AI ile düzelt
      final result = await SmartOcr.processImageToText(
        imageFile: selectedImage.value!,
      );

      // SmartOCR controller'dan sonuçları al
      ocrResult.value = smartOcrController.ocrResult.value;
      aiCorrectionResult.value = smartOcrController.aiCorrectionResult.value;

      return result;
    } catch (e) {
      errorMessage.value = 'İşlem başarısız oldu: $e';
      return '';
    } finally {
      isLoading.value = false;
    }
  }

  /// Sonuçları temizle
  void clearResults() {
    selectedImage.value = null;
    ocrResult.value = null;
    aiCorrectionResult.value = null;
    errorMessage.value = null;
  }
}
