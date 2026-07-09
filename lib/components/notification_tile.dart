import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/spacing.dart';

class NotificationTile extends StatelessWidget {
  final String text;
  final String? routeName;
  final VoidCallback? onTap;
  final bool clearStack;

  const NotificationTile({
    super.key,
    required this.text,
    required this.onTap,
    this.routeName,
    this.clearStack = false,
  }) : assert(
         (routeName != null) ^ (onTap != null),
         'Provide either routeName or onTap, but not both.',
       );
  void _handleTap(BuildContext context) {
    if (onTap != null) {
      onTap!();
      return;
    }
    final route = routeName!;
    if (clearStack) {
      Navigator.pushNamedAndRemoveUntil(context, route, (r) => false);
    } else {
      Navigator.pushNamed(context, route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
      ).copyWith(bottom: 12.0), // "Width/Lenght" of the button
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppSpacing.pillBorderRadius),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => _handleTap(context),
          borderRadius: BorderRadius.circular(AppSpacing.pillBorderRadius),
          splashColor: AppColors.purple.withValues(alpha: 0.4),
          highlightColor: AppColors.lavender.withValues(alpha: 0.1),
          child: Ink(
            decoration: BoxDecoration(
              color: AppColors.cream,
              borderRadius: BorderRadius.circular(AppSpacing.pillBorderRadius),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 10.0,
            ), // "Height" of the button
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                  color: AppColors.purple,
                  fontFamily: 'Jersey20',
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
