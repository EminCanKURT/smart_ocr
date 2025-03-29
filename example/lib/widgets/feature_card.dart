import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:example/widgets/custom_card.dart';

/// Özellik kartı widget'ı
class FeatureCard extends StatelessWidget {
  /// Constructor
  const FeatureCard({
    required this.title,
    required this.description,
    required this.icon,
    super.key,
    this.onTap,
  });

  /// Kart başlığı
  final String title;

  /// Kart açıklaması
  final String description;

  /// Kart ikonu
  final IconData icon;

  /// Kart tıklama fonksiyonu
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomCard(
      onTap: onTap,
      padding: EdgeInsets.all(16.r),
      margin: EdgeInsets.only(bottom: 16.r),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48.r,
            height: 48.r,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withAlpha(25),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              icon,
              size: 24.r,
              color: theme.colorScheme.primary,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  description,
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          if (onTap != null) ...[
            SizedBox(width: 8.w),
            Icon(
              Icons.arrow_forward_ios,
              size: 16.r,
              color: theme.colorScheme.primary,
            ),
          ],
        ],
      ),
    );
  }
}
