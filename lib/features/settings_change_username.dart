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
class SettingsChangeUsername extends StatefulWidget {
  const SettingsChangeUsername({super.key});

  @override
  State<SettingsChangeUsername> createState() => _SettingsChangeUsernameState();
}

class _SettingsChangeUsernameState extends State<SettingsChangeUsername> {
  final oldUsernameController = TextEditingController();
  final oldUsernameController2 = TextEditingController();
  final newUsernameController = TextEditingController();

  String errorMessage = '';

  @override
  void dispose() {
    oldUsernameController.dispose();
    oldUsernameController2.dispose();
    newUsernameController.dispose();
    super.dispose();
  }

  void changeUsername() async {
    if (newUsernameController.text.isEmpty ||
        oldUsernameController.text.isEmpty ||
        oldUsernameController2.text.isEmpty) {
      setState(() {
        errorMessage = 'Please fill in all fields';
      });
      return;
    }
    if (oldUsernameController.text != oldUsernameController2.text) {
      setState(() {
        errorMessage = 'Old usernames do not match';
      });
      return;
    }
    try {
      await authService.value.updateUsername(
        newUsername: newUsernameController.text,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.purple,
            content: Text(
              'Username changed successfully!',
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
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
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
              CustomHeaders(title: 'Change Your Username', showBack: true),

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
                            controller: oldUsernameController,
                            hintText: 'Old Username',
                            obscureText: false,
                            showToggle: false,
                          ),
                          const SizedBox(height: 20),
                          CustomTextfield(
                            controller: oldUsernameController2,
                            hintText: 'Confirm Old Username',
                            obscureText: false,
                            showToggle: false,
                          ),
                          const SizedBox(height: 20),
                          CustomTextfield(
                            controller: newUsernameController,
                            hintText: 'New Username',
                            obscureText: false,
                            showToggle: false,
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
                          const SizedBox(height: 20),
                          CustomButton(
                            text: 'Confirm',
                            onTap: () =>
                                changeUsername(), // Temporary does nothing until AUTH is implemented
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
