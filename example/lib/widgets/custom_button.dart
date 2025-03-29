import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Buton türleri
enum CustomButtonType {
  /// Birincil buton
  primary,

  /// İkincil buton
  secondary,

  /// Tehlike butonu
  danger,
}

/// Özel buton widget'ı
class CustomButton extends StatelessWidget {
  /// Constructor
  const CustomButton({
    required this.text,
    required this.onPressed,
    super.key,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.type = CustomButtonType.primary,
    this.padding,
    this.margin,
    this.height,
    this.width,
    this.borderRadius,
    this.fontSize,
  });

  /// Buton metni
  final String text;

  /// Buton ikonu
  final IconData? icon;

  /// Tıklama fonksiyonu
  final VoidCallback onPressed;

  /// Yükleniyor durumu
  final bool isLoading;

  /// Tam genişlik
  final bool isFullWidth;

  /// Buton türü
  final CustomButtonType type;

  /// İç boşluk
  final EdgeInsetsGeometry? padding;

  /// Dış boşluk
  final EdgeInsetsGeometry? margin;

  /// Buton yüksekliği
  final double? height;

  /// Buton genişliği
  final double? width;

  /// Buton kenar yuvarlaklığı
  final double? borderRadius;

  /// Yazı boyutu
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Buton türüne göre renkler
    Color backgroundColor;
    Color foregroundColor;

    switch (type) {
      case CustomButtonType.primary:
        backgroundColor = theme.colorScheme.primary;
        foregroundColor = theme.colorScheme.onPrimary;
        break;
      case CustomButtonType.secondary:
        backgroundColor = theme.colorScheme.secondary;
        foregroundColor = theme.colorScheme.onSecondary;
        break;
      case CustomButtonType.danger:
        backgroundColor = theme.colorScheme.error;
        foregroundColor = theme.colorScheme.onError;
        break;
    }

    return Container(
      margin: margin,
      width: isFullWidth ? double.infinity : width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          padding:
              padding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
          ),
          elevation: 2,
        ),
        child: isLoading
            ? SizedBox(
                height: 24.r,
                width: 24.r,
                child: CircularProgressIndicator(
                  color: foregroundColor,
                  strokeWidth: 2.r,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 24.r),
                    SizedBox(width: 8.w),
                  ],
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: fontSize ?? 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
