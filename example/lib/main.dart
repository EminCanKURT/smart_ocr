import 'package:example/constants/route_constants.dart';
import 'package:example/constants/theme_constants.dart';
import 'package:example/controllers/example_controller.dart';
import 'package:example/screens/example_ai_correction_screen.dart';
import 'package:example/screens/example_home_screen.dart';
import 'package:example/screens/example_ocr_process_screen.dart';
import 'package:example/screens/example_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_ocr/presentation/controllers/smart_ocr_controller.dart';
import 'package:smart_ocr/smart_ocr.dart';

/// Örnek uygulama
void main() async {
  // Widget binding'i başlat
  WidgetsFlutterBinding.ensureInitialized();

  // SmartOCR paketini başlat
  await SmartOcr.init();

  // Uygulamayı başlat
  runApp(const SmartOcrExampleApp());
}

/// SmartOCR örnek uygulaması
class SmartOcrExampleApp extends StatelessWidget {
  /// Constructor
  const SmartOcrExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ExampleController'ı başlat
    Get.put(
      ExampleController(
        smartOcrController: Get.find<SmartOcrController>(),
      ),
    );

    // ScreenUtil'i başlat
    return ScreenUtilInit(
      // Tasarım boyutları (Figma veya Adobe XD'deki tasarım boyutları)
      designSize: const Size(375, 812), // iPhone X boyutları
      // Minimum boyutlar
      minTextAdapt: true,
      // Metin ölçeklendirme faktörü
      splitScreenMode: true,
      // Uygulama
      builder: (context, child) {
        return GetMaterialApp(
          // Uygulama başlığı
          title: 'SmartOCR Örnek Uygulaması',
          // Tema
          theme: ThemeConstants.lightTheme,
          // Karanlık tema
          darkTheme: ThemeConstants.darkTheme,
          // Hata ayıklama banner'ını gizle
          debugShowCheckedModeBanner: false,
          // Başlangıç ekranı
          home: const ExampleHomeScreen(),
          // Rotalar
          getPages: [
            // Örnek uygulama rotaları
            GetPage(
              name: ExampleRouteConstants.home,
              page: () => const ExampleHomeScreen(),
              transition: Transition.fadeIn,
            ),
            GetPage(
              name: ExampleRouteConstants.result,
              page: () => const ExampleResultScreen(),
              transition: Transition.rightToLeft,
            ),
            GetPage(
              name: ExampleRouteConstants.ocrProcess,
              page: () => const ExampleOcrProcessScreen(),
              transition: Transition.rightToLeft,
            ),
            GetPage(
              name: ExampleRouteConstants.aiCorrection,
              page: () => const ExampleAiCorrectionScreen(),
              transition: Transition.rightToLeft,
            ),
          ],
        );
      },
    );
  }
}
