import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/spacing.dart';
import '../components/custom_headers.dart';
import '../components/custom_button.dart';
import '../components/custom_textfield.dart';

//Rename and change Blank to whatever you want and change it in the main.dart as well, just a template if needed
//To go back to the test page, click "Template Page", you can change the name and it will still work
class SettingsChangeEmail extends StatelessWidget {
  SettingsChangeEmail({super.key});

  final oldEmailController = TextEditingController();
  final oldEmailController2 = TextEditingController();
  final newEmailController = TextEditingController();

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
              CustomHeaders(title: 'Change Your Email', showBack: true),

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
                            controller: oldEmailController,
                            hintText: 'Old Email',
                            obscureText: false,
                            showToggle: false,
                          ),
                          const SizedBox(height: 20),
                          CustomTextfield(
                            controller: oldEmailController2,
                            hintText: 'Confirm Old Email',
                            obscureText: false,
                            showToggle: false,
                          ),
                          const SizedBox(height: 20),
                          CustomTextfield(
                            controller: newEmailController,
                            hintText: 'New Email',
                            obscureText: false,
                            showToggle: false,
                          ),
                          const SizedBox(height: 20),
                          CustomButton(
                            text: 'Confirm',
                            onTap: () =>
                                (), // Temporary does nothing until AUTH is implemented
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
