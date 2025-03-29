import 'package:get/get.dart';
import 'package:smart_ocr/data/repositories/ai_correction_repository_impl.dart';
import 'package:smart_ocr/data/repositories/ocr_repository_impl.dart';
import 'package:smart_ocr/domain/repositories/ai_correction_repository.dart';
import 'package:smart_ocr/domain/repositories/ocr_repository.dart';
import 'package:smart_ocr/presentation/controllers/smart_ocr_controller.dart';

/// SmartOCR için GetX bağımlılık enjeksiyonları
class SmartOcrBindings extends Bindings {
  @override
  void dependencies() {
    // Repository'leri tek bir blokta tanımla
    _setupRepositories();

    // Controller'ı tanımla
    _setupControllers();
  }

  /// Repository'leri tanımla
  void _setupRepositories() {
    Get
      ..lazyPut<OcrRepository>(
        OcrRepositoryImpl.new,
        fenix: true,
      )
      ..lazyPut<AiCorrectionRepository>(
        AiCorrectionRepositoryImpl.new,
        fenix: true,
      );
  }

  /// Controller'ları tanımla
  void _setupControllers() {
    Get.lazyPut<SmartOcrController>(
      () => SmartOcrController(
        ocrRepository: Get.find<OcrRepository>(),
        aiCorrectionRepository: Get.find<AiCorrectionRepository>(),
      ),
      fenix: true,
    );
  }
}
