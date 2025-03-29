import 'package:example/constants/route_constants.dart';
import 'package:example/controllers/example_controller.dart';
import 'package:example/widgets/custom_button.dart';
import 'package:example/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/// Örnek sonuç ekranı
class ExampleResultScreen extends StatelessWidget {
  /// Constructor
  const ExampleResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ExampleController'ı al
    final controller = Get.find<ExampleController>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sonuç'),
      ),
      body: Padding(
        padding: EdgeInsets.all(14.r),
        child: SingleChildScrollView(
          child: Obx(() {
            final ocrResult = controller.ocrResult.value;
            final aiCorrectionResult = controller.aiCorrectionResult.value;

            if (ocrResult == null || aiCorrectionResult == null) {
              return const Center(
                child: Text('Sonuç bulunamadı'),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Resim önizleme
                Container(
                  height: 200.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: theme.colorScheme.primary.withOpacity(0.5),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.file(
                      controller.selectedImage.value!,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                // OCR sonucu
                Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: theme.colorScheme.outline.withOpacity(0.5),
                    ),
                  ),
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'OCR Sonucu',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.copy),
                            onPressed: () {
                              Clipboard.setData(
                                ClipboardData(text: ocrResult.text),
                              );
                              Get.snackbar(
                                'Kopyalandı',
                                'OCR sonucu panoya kopyalandı',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            },
                            tooltip: 'Kopyala',
                            iconSize: 20.r,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        constraints: BoxConstraints(maxHeight: 100.h),
                        child: SingleChildScrollView(
                          child: Text(
                            ocrResult.text,
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildInfoChip(
                            context,
                            'Güven: ${ocrResult.confidence.toStringAsFixed(1)}%',
                            Icons.sentiment_satisfied_alt,
                          ),
                          _buildInfoChip(
                            context,
                            'Süre: ${ocrResult.processTime} ms',
                            Icons.timer,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                // AI düzeltme sonucu
                Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: theme.colorScheme.outline.withOpacity(0.5),
                    ),
                  ),
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'AI Düzeltme Sonucu',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.copy),
                            onPressed: () {
                              Clipboard.setData(
                                ClipboardData(
                                  text: aiCorrectionResult.correctedText,
                                ),
                              );
                              Get.snackbar(
                                'Kopyalandı',
                                'AI düzeltme sonucu panoya kopyalandı',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            },
                            tooltip: 'Kopyala',
                            iconSize: 20.r,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        constraints: BoxConstraints(maxHeight: 100.h),
                        child: SingleChildScrollView(
                          child: Text(
                            aiCorrectionResult.correctedText,
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                // Paylaş butonu
                ElevatedButton.icon(
                  icon: const Icon(Icons.share),
                  label: const Text('Sonucu Paylaş'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 48.h),
                  ),
                  onPressed: () {
                    Get.snackbar(
                      'Uyarı',
                      'Bu özellik henüz uygulanmadı',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                ),
                SizedBox(height: 8.h),
                // Yeni görüntü seç butonu
                OutlinedButton.icon(
                  icon: const Icon(Icons.refresh),
                  label: const Text('Yeni Görüntü Seç'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(double.infinity, 48.h),
                  ),
                  onPressed: () {
                    // Sonuçları temizle ve ana ekrana dön
                    controller.clearResults();
                    Get.back();
                  },
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  /// Bilgi çipi oluştur
  Widget _buildInfoChip(BuildContext context, String label, IconData icon) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 4.r),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16.r,
            color: theme.colorScheme.primary,
          ),
          SizedBox(width: 4.w),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
