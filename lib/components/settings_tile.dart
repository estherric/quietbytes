import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/spacing.dart';

class SettingsTile extends StatefulWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onTap;

  const SettingsTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.onTap,
  });

  @override
  State<SettingsTile> createState() => _SettingsTileState();
}

class _SettingsTileState extends State<SettingsTile> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: ListTile(
        leading: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: AppColors.rose,
            shape: BoxShape.circle,
          ),
          child: Icon(widget.icon, color: AppColors.cream, size: 20),
        ),
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Jersey20',
            color: _isPressed ? AppColors.gold : AppColors.cream,
          ),
        ),
        subtitle: Text(
          widget.subtitle,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Jersey20',
            color: _isPressed
                ? AppColors.gold.withValues(alpha: 0.8)
                : AppColors.cream.withValues(alpha: 0.8),
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.horizontalPaddingWidth,
          vertical: 2.0,
        ),
      ),
    );
  }
}
