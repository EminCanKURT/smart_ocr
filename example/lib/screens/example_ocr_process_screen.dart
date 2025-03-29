import 'package:example/constants/route_constants.dart';
import 'package:example/controllers/example_controller.dart';
import 'package:example/widgets/custom_button.dart';
import 'package:example/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/// Örnek OCR işlemi ekranı
class ExampleOcrProcessScreen extends StatefulWidget {
  /// Constructor
  const ExampleOcrProcessScreen({super.key});

  @override
  State<ExampleOcrProcessScreen> createState() =>
      _ExampleOcrProcessScreenState();
}

class _ExampleOcrProcessScreenState extends State<ExampleOcrProcessScreen> {
  // ExampleController
  late final ExampleController _controller;

  @override
  void initState() {
    super.initState();
    // Controller'ı al
    _controller = Get.find<ExampleController>();
    // OCR işlemini başlat
    _controller.startOcrProcess();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('OCR İşlemi'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Obx(() {
            final isProcessing = _controller.isOcrProcessing.value;
            final progress = _controller.ocrProgress.value;
            final statusMessage = _controller.ocrStatusMessage.value;
            final errorMessage = _controller.errorMessage.value;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Başlık
                Text(
                  isProcessing
                      ? 'OCR İşlemi Devam Ediyor'
                      : 'OCR İşlemi Tamamlandı',
                  style: theme.textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.h),
                // Seçilen görüntü
                if (_controller.selectedImage.value != null) ...[
                  Text(
                    'Seçilen Görüntü:',
                    style: theme.textTheme.titleMedium,
                  ),
                  SizedBox(height: 8.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.file(
                      _controller.selectedImage.value!,
                      height: 150.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
                SizedBox(height: 16.h),
                // İşlem göstergesi
                if (isProcessing) ...[
                  // İlerleme çubuğu
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: theme.colorScheme.primary.withAlpha(50),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      theme.colorScheme.primary,
                    ),
                    minHeight: 10.h,
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  SizedBox(height: 16.h),
                  // Durum mesajı
                  Text(
                    statusMessage,
                    style: theme.textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32.h),
                  // Yükleme göstergesi
                  LoadingIndicator(
                    size: 60.r,
                    color: theme.colorScheme.primary,
                    message: 'Lütfen bekleyin...',
                  ),
                ],
                // Hata mesajı
                if (errorMessage != null) ...[
                  SizedBox(height: 16.h),
                  Container(
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.error.withAlpha(50),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      errorMessage,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.error,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
                // OCR sonucu
                if (!isProcessing && _controller.ocrResult.value != null) ...[
                  SizedBox(height: 16.h),
                  // Tamamlandı ikonu
                  Icon(
                    Icons.check_circle,
                    size: 60.r,
                    color: Colors.green,
                  ),
                  SizedBox(height: 16.h),
                  // Tamamlandı mesajı
                  Text(
                    'OCR işlemi başarıyla tamamlandı!',
                    style: theme.textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.h),
                  // OCR sonucu
                  Text(
                    'OCR Sonucu:',
                    style: theme.textTheme.titleMedium,
                  ),
                  SizedBox(height: 8.h),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: theme.colorScheme.outline.withAlpha(128),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Text(
                          _controller.ocrResult.value!.text,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  // AI düzeltme ekranına git butonu
                  CustomButton(
                    text: 'AI Düzeltme İşlemine Geç',
                    icon: Icons.auto_fix_high,
                    isFullWidth: true,
                    onPressed: () {
                      // AI düzeltme ekranına git
                      Get.toNamed(ExampleRouteConstants.aiCorrection);
                    },
                  ),
                ],
                if (!isProcessing && _controller.ocrResult.value == null) ...[
                  const Spacer(),
                ],
                SizedBox(height: 16.h),
                // İptal butonu
                if (isProcessing)
                  CustomButton(
                    text: 'İptal Et',
                    icon: Icons.cancel,
                    type: CustomButtonType.secondary,
                    isFullWidth: true,
                    onPressed: () {
                      // Ana ekrana dön
                      Get.back();
                    },
                  ),
                // Ana ekrana dön butonu
                if (!isProcessing)
                  CustomButton(
                    text: 'Ana Ekrana Dön',
                    icon: Icons.home,
                    type: CustomButtonType.secondary,
                    isFullWidth: true,
                    onPressed: () {
                      // Ana ekrana dön
                      Get.offAllNamed(ExampleRouteConstants.home);
                    },
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
