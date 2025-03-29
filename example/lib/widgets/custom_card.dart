import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Özel kart widget'ı
class CustomCard extends StatelessWidget {
  /// Constructor
  const CustomCard({
    required this.child,
    super.key,
    this.onTap,
    this.padding,
    this.margin,
    this.color,
    this.borderRadius,
    this.elevation,
    this.border,
    this.width,
    this.height,
  });

  /// Kart içeriği
  final Widget child;

  /// Tıklama fonksiyonu
  final VoidCallback? onTap;

  /// İç boşluk
  final EdgeInsetsGeometry? padding;

  /// Dış boşluk
  final EdgeInsetsGeometry? margin;

  /// Kart arka plan rengi
  final Color? color;

  /// Kenar yuvarlaklığı
  final double? borderRadius;

  /// Yükseklik efekti
  final double? elevation;

  /// Kenar çizgisi
  final BoxBorder? border;

  /// Genişlik
  final double? width;

  /// Yükseklik
  final double? height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final card = Card(
      margin: margin ?? EdgeInsets.zero,
      elevation: elevation ?? 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
        side: border != null
            ? const BorderSide(
                color: Colors.transparent,
                width: 0,
              )
            : BorderSide.none,
      ),
      color: color ?? theme.cardColor,
      child: SizedBox(
        width: width,
        height: height,
        child: Padding(
          padding: padding ?? EdgeInsets.all(16.r),
          child: child,
        ),
      ),
    );

    // Tıklanabilir ise InkWell içine al
    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
        child: card,
      );
    }

    return card;
  }
}
