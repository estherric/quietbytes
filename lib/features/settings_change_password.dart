import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/spacing.dart';
import '../components/custom_headers.dart';
import '../components/custom_button.dart';
import '../components/custom_textfield.dart';

import '../app/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Rename and change Blank to whatever you want and change it in the main.dart as well, just a template if needed
//To go back to the test page, click "Template Page", you can change the name and it will still work
class SettingsChangePassword extends StatefulWidget {
  const SettingsChangePassword({super.key});

  @override
  State<SettingsChangePassword> createState() => _SettingsChangePasswordState();
}

class _SettingsChangePasswordState extends State<SettingsChangePassword> {
  final emailController = TextEditingController();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final newPasswordController2 = TextEditingController();

  String errorMessage = '';

  @override
  void dispose() {
    emailController.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    newPasswordController2.dispose();
    super.dispose();
  }

  void changePassword() async {
    if (emailController.text.isEmpty ||
        oldPasswordController.text.isEmpty ||
        newPasswordController.text.isEmpty ||
        newPasswordController2.text.isEmpty) {
      setState(() {
        errorMessage = 'Please fill in all fields';
      });
      return;
    }
    if (newPasswordController.text != newPasswordController2.text) {
      setState(() {
        errorMessage = 'New passwords do not match';
      });
      return;
    }
    try {
      await authService.value.resetPasswordFromCurrentPassword(
        currentPassword: oldPasswordController.text,
        newPassword: newPasswordController.text,
        email: emailController.text,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.purple,
            content: Text(
              'Password changed successfully',
              style: TextStyle(
                color: AppColors.gold,
                fontFamily: 'Jersey20',
                fontSize: 16,
              ),
            ),
            showCloseIcon: true,
          ),
        );
        setState(() {
          errorMessage = '';
        });
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      // Handle errors, e.g., show an error message
      setState(() {
        errorMessage = e.message ?? 'An error occurred';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lavender,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.horizontalPaddingWidth,
            vertical: AppSpacing.verticalPaddingIsland,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Top pill (Template Page)
              CustomHeaders(title: 'Change Your Password', showBack: true),

              const SizedBox(
                height: AppSpacing.pillsSpacing,
              ), // Spacing between the two pills
              //2nd Pill (Background pill, login, )
              Expanded(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.purple,
                        borderRadius: BorderRadius.circular(
                          AppSpacing.pillBorderRadius,
                        ),
                      ),
                    ),

                    // Put whatever you want in the purple pill here (logo, text, buttons, etc.)
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // ------ START HERE (I think)--------
                          CustomTextfield(
                            controller: emailController,
                            hintText: 'Email',
                            obscureText: false,
                            showToggle: false,
                          ),
                          const SizedBox(height: 20),
                          CustomTextfield(
                            controller: oldPasswordController,
                            hintText: 'Old Password',
                            obscureText: true,
                            showToggle: true,
                          ),
                          const SizedBox(height: 20),
                          CustomTextfield(
                            controller: newPasswordController,
                            hintText: 'New Password',
                            obscureText: true,
                            showToggle: true,
                          ),
                          const SizedBox(height: 20),
                          CustomTextfield(
                            controller: newPasswordController2,
                            hintText: 'Confirm New Password',
                            obscureText: true,
                            showToggle: true,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            errorMessage,
                            style: TextStyle(
                              color: AppColors.cream,
                              fontFamily: 'Jersey20',
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 20),
                          CustomButton(
                            text: 'Change Password',
                            onTap: () => changePassword(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
