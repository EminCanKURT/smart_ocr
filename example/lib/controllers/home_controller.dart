import 'package:example/constants/route_constants.dart';
import 'package:get/get.dart';

/// Ana ekran controller'ı
class HomeController extends GetxController {
  /// Yükleniyor durumu
  final isLoading = false.obs;

  /// Hata mesajı
  final errorMessage = Rx<String?>(null);

  /// Görüntü yükleme işlemini başlat
  Future<void> startImageCapture() async {
    try {
      isLoading.value = true;
      errorMessage.value = null;

      // Burada görüntü yükleme işlemi yapılabilir
      await Future.delayed(const Duration(seconds: 1));

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = 'Görüntü yükleme işlemi başarısız oldu: $e';
    }
  }

  /// Smart OCR ana ekranına yönlendir
  void navigateToSmartOcrHome() {
    Get.toNamed(ExampleRouteConstants.home);
  }

  /// Örnek OCR işlemi ekranına yönlendir
  void navigateToExampleOcrProcess() {
    Get.toNamed(ExampleRouteConstants.ocrProcess);
  }

  /// Örnek AI düzeltme ekranına yönlendir
  void navigateToExampleAiCorrection() {
    Get.toNamed(ExampleRouteConstants.aiCorrection);
  }

  /// Örnek sonuç ekranına yönlendir
  void navigateToExampleResult() {
    Get.toNamed(ExampleRouteConstants.result);
  }
}
