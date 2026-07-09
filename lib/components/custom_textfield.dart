import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/spacing.dart';

class CustomTextfield extends StatefulWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final bool showToggle;

  const CustomTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.showToggle = false,
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  late bool _isObscure;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    // Username textfield
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30.0,
      ), // "Width/Lenght" of the button
      child: TextField(
        controller: widget.controller,
        obscureText: _isObscure,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.pillBorderRadius),
            borderSide: const BorderSide(color: AppColors.lavender),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.pillBorderRadius),
            borderSide: const BorderSide(color: AppColors.gold),
          ),
          fillColor: AppColors.lavender,
          filled: true,
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: AppColors.purple,
            fontFamily: 'Jersey20',
            fontSize: 20,
          ),
          // Suffix icon for password textfield
          suffixIcon: widget.showToggle
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                  icon: Icon(
                    _isObscure ? Icons.visibility_off : Icons.visibility,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
