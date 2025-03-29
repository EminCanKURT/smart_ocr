import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Yükleme göstergesi widget'ı
class LoadingIndicator extends StatelessWidget {
  /// Constructor
  const LoadingIndicator({
    super.key,
    this.size = 40,
    this.color,
    this.strokeWidth = 4.0,
    this.message,
    this.padding,
  });

  /// Gösterge boyutu
  final double size;

  /// Gösterge rengi
  final Color? color;

  /// Çizgi kalınlığı
  final double strokeWidth;

  /// Mesaj
  final String? message;

  /// İç boşluk
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: padding ?? EdgeInsets.all(16.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              color: color ?? theme.colorScheme.primary,
              strokeWidth: strokeWidth,
            ),
          ),
          if (message != null) ...[
            SizedBox(height: 16.h),
            Text(
              message!,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
