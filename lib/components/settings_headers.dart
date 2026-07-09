import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/spacing.dart';

class SettingsHeaders extends StatelessWidget {
  final String title;
  final IconData icon;

  const SettingsHeaders({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.horizontalPaddingWidth,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.rose,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: AppColors.cream, size: 29),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: AppColors.cream,
                  fontFamily: 'Jersey20',
                  fontSize: 26,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ), // Distance between the logi button and the Divider, could be adjusted later
        Divider(
          color: AppColors.cream.withValues(alpha: 0.4),
          thickness: 2,
          indent: AppSpacing.horizontalPaddingWidth,
          endIndent: AppSpacing.horizontalPaddingWidth,
        ),
      ],
    );
  }
}
