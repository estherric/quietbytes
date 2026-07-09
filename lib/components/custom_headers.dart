import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/spacing.dart';

class CustomHeaders extends StatelessWidget {
  final String title;
  final bool showBack;
  final bool showSettings;
  final VoidCallback? onBack;

  const CustomHeaders({
    super.key,
    required this.title,
    this.showBack = false,
    this.showSettings = false,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppSpacing.topPillHeight,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.purple,
        borderRadius: BorderRadius.circular(AppSpacing.pillBorderRadius),
      ),
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          Center(
            child: Text(
              title,
              style: const TextStyle(
                color: AppColors.cream,
                fontFamily: 'Jersey20',
                fontSize: 30,
              ),
            ),
          ),
          if (showBack)
            Positioned(
              left: AppSpacing.topPillTextPadding,
              top: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: onBack ?? () => Navigator.pop(context),
                child: const Icon(
                  Icons.arrow_back_ios_rounded,
                  color: AppColors.cream,
                  size: 30,
                ),
              ),
            ),
          if (showSettings)
            Positioned(
              right: AppSpacing.topPillTextPadding,
              top: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: () {
                  if (ModalRoute.of(context)?.settings.name != '/settings') {
                    Navigator.pushNamed(context, '/settings');
                  }
                },
                child: const Icon(
                  Icons.settings_rounded,
                  color: AppColors.cream,
                  size: 30,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
