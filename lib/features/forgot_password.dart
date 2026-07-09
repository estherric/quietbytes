import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/spacing.dart';
import '../components/custom_headers.dart';

import '../components/custom_textfield.dart';
import '../components/custom_button.dart';

import '../app/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Rename and change Blank to whatever you want and change it in the main.dart as well, just a template if needed
//To go back to the test page, click "Template Page", you can change the name and it will still work
class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();
  String errorMessage = '';

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void forgotPassword() async {
    if (emailController.text.isEmpty) {
      setState(() {
        errorMessage = 'Please enter your email';
      });
      return;
    }
    try {
      await authService.value.resetPassword(email: emailController.text);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.purple,
            content: Text(
              'Password reset link sent to your email',
              style: TextStyle(
                color: AppColors.cream,
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
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message ?? 'There is an error';
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
              CustomHeaders(title: 'Forgot Password', showBack: true),

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
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 50.0,
                      ), //How far the text is from the top of the purple pill
                      child: Column(
                        children: [
                          // ------ START HERE (I think)--------
                          const SizedBox(height: 220),
                          CustomTextfield(
                            controller: emailController,
                            hintText: 'Enter your email',
                            obscureText: false,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            errorMessage,
                            style: TextStyle(
                              color: AppColors.gold,
                              fontFamily: 'Jersey20',
                              fontSize: 14,
                            ),
                          ),
                          CustomButton(
                            text: 'Send Reset Link',
                            onTap: () => forgotPassword(),
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
