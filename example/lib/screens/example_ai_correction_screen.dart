import 'package:example/constants/route_constants.dart';
import 'package:example/controllers/example_controller.dart';
import 'package:example/widgets/custom_button.dart';
import 'package:example/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/// Örnek AI düzeltme ekranı
class ExampleAiCorrectionScreen extends StatefulWidget {
  /// Constructor
  const ExampleAiCorrectionScreen({super.key});

  @override
  State<ExampleAiCorrectionScreen> createState() =>
      _ExampleAiCorrectionScreenState();
}

class _ExampleAiCorrectionScreenState extends State<ExampleAiCorrectionScreen> {
  // ExampleController
  late final ExampleController _controller;

  @override
  void initState() {
    super.initState();
    // Controller'ı al
    _controller = Get.find<ExampleController>();
    // AI düzeltme işlemini başlat
    _controller.startAiCorrectionProcess();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Düzeltme'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Obx(() {
            final isProcessing = _controller.isAiCorrectionProcessing.value;
            final progress = _controller.aiCorrectionProgress.value;
            final statusMessage = _controller.aiCorrectionStatusMessage.value;
            final errorMessage = _controller.errorMessage.value;
            final ocrResult = _controller.ocrResult.value;
            final aiCorrectionResult = _controller.aiCorrectionResult.value;

            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Başlık
                  Text(
                    isProcessing
                        ? 'AI Düzeltme Devam Ediyor'
                        : 'AI Düzeltme Tamamlandı',
                    style: theme.textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.h),
                  // OCR sonucu
                  if (ocrResult != null) ...[
                    Text(
                      'OCR Sonucu:',
                      style: theme.textTheme.titleMedium,
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      constraints: BoxConstraints(maxHeight: 250.h),
                      padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: theme.colorScheme.outline.withAlpha(128),
                        ),
                      ),
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Text(
                          ocrResult.text,
                          style: theme.textTheme.bodyMedium,
                        ),
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
                    SizedBox(height: 16.h),
                    // Bilgi metni
                    Text(
                      'AI modeli metni analiz ediyor ve düzeltiyor. Bu işlem birkaç saniye sürebilir.',
                      style: theme.textTheme.bodyMedium,
                      textAlign: TextAlign.center,
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
                  // AI düzeltme sonucu
                  if (!isProcessing && aiCorrectionResult != null) ...[
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
                      'AI düzeltme işlemi başarıyla tamamlandı!',
                      style: theme.textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.h),
                    // AI düzeltme sonucu
                    Text(
                      'AI Düzeltme Sonucu:',
                      style: theme.textTheme.titleMedium,
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      constraints: BoxConstraints(maxHeight: 300.h),
                      padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: theme.colorScheme.outline.withAlpha(128),
                        ),
                      ),
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Text(
                          aiCorrectionResult.correctedText,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    // Sonuç ekranına git butonu
                    CustomButton(
                      text: 'Sonuçları Görüntüle',
                      icon: Icons.visibility,
                      isFullWidth: true,
                      onPressed: () {
                        // Sonuç ekranına git
                        Get.toNamed(ExampleRouteConstants.result);
                      },
                    ),
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
              ),
            );
          }),
        ),
      ),
    );
  }
}
