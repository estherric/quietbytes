import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/spacing.dart';
import '../components/custom_button.dart';
import '../components/custom_headers.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

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
              //Top pill (Welcome to QuietBytes!)
              CustomHeaders(title: 'Welcome to QuietBytes!'),

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

                    // Logo + text + button
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 50.0,
                      ), //How far the text is from the top of the purple pill
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.textPaddingFromSides,
                            ), // Text padding from the sides of the purple pill
                            child: const Text(
                              'Want to try new hobbies, food, and make friends at the same time?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.cream,
                                fontFamily: 'Jersey20',
                                fontSize: 28,
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 0,
                          ), // Spacing between the text and the logo
                          // Logo
                          const Image(
                            image: AssetImage('assets/images/welcomeMap.png'),
                            width: 400,
                            height: 400,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(
                            height: 50,
                          ), // Spacing between the logo and the button
                          CustomButton(
                            text: 'Get Started',
                            routeName: '/login',
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
