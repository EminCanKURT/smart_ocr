import 'package:example/constants/route_constants.dart';
import 'package:example/controllers/example_controller.dart';
import 'package:example/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_ocr/core/constants/constants.dart';

/// Örnek ana ekran
class ExampleHomeScreen extends StatelessWidget {
  /// Constructor
  const ExampleHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // HomeController'ı başlat
    final homeController = Get.put(HomeController());
    // ExampleController'ı al
    final exampleController = Get.find<ExampleController>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart OCR Örnek'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Başlık
              Text(
                'Smart OCR Paketi',
                style: theme.textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              // Alt başlık
              Text(
                'Görüntülerden metin çıkarma ve AI ile düzeltme',
                style: theme.textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              // Görüntü seçme butonu
              Obx(() => exampleController.selectedImage.value != null
                  ? Column(
                      children: [
                        // Seçilen görüntü
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Image.file(
                            exampleController.selectedImage.value!,
                            height: 200.h,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        // Görüntü değiştir butonu
                        ElevatedButton.icon(
                          icon: const Icon(Icons.image),
                          label: const Text('Görüntüyü Değiştir'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.secondary,
                            foregroundColor: theme.colorScheme.onSecondary,
                            minimumSize: Size(double.infinity, 48.h),
                          ),
                          onPressed: () => _showImageSourceDialog(
                            context,
                            exampleController,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        // Tek adımda işleme butonu
                        ElevatedButton.icon(
                          icon: const Icon(Icons.auto_awesome),
                          label: const Text('OCR ve AI Düzeltme Yap'),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 48.h),
                          ),
                          onPressed: () async {
                            // Yükleniyor dialogu göster
                            Get.dialog(
                              const Center(
                                child: CircularProgressIndicator(),
                              ),
                              barrierDismissible: false,
                            );

                            // Tek adımda işlemi başlat
                            final result = await exampleController
                                .processImageWithOneStep();

                            // Yükleniyor dialogunu kapat
                            Get.back();

                            if (result.isNotEmpty) {
                              // Başarılı olursa sonuç ekranına git
                              homeController.navigateToExampleResult();
                            } else {
                              // Başarısız olursa hata mesajı göster
                              Get.snackbar(
                                'Hata',
                                exampleController.errorMessage.value ??
                                    'İşlem başarısız oldu.',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: theme.colorScheme.error,
                                colorText: theme.colorScheme.onError,
                              );
                            }
                          },
                        ),
                      ],
                    )
                  : ElevatedButton.icon(
                      icon: const Icon(Icons.image),
                      label: const Text('Görüntü Seç'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 48.h),
                      ),
                      onPressed: () => _showImageSourceDialog(
                        context,
                        exampleController,
                      ),
                    )),
              SizedBox(height: 16.h),
              // Bilgi metni
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    'Bu örnek uygulama, Smart OCR paketinin nasıl kullanılacağını göstermektedir. Görüntü seçtikten sonra, "OCR ve AI Düzeltme Yap" butonuna tıklayarak tek adımda görüntüden metin çıkarabilir ve düzeltebilirsiniz.',
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Görüntü kaynağı seçme dialogu
  void _showImageSourceDialog(
    BuildContext context,
    ExampleController controller,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Görüntü Kaynağı Seçin'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Kamera'),
              onTap: () {
                Get.back();
                controller.pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Galeri'),
              onTap: () {
                Get.back();
                controller.pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }
}
