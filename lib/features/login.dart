import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/spacing.dart';
import '../components/custom_textfield.dart';
import '../components/custom_button.dart';
import '../components/custom_headers.dart';

import '../app/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String errorMessage = '';

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signUserIn() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      setState(() {
        errorMessage = 'Please fill in all fields';
      });
      return;
    }
    try {
      await authService.value.signIn(
        email: emailController.text,
        password: passwordController.text,
      );
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
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
                      margin: const EdgeInsets.only(
                        top: 20,
                      ), // To create a slight overlap with the top pill
                      decoration: BoxDecoration(
                        color: AppColors.purple,
                        borderRadius: BorderRadius.circular(
                          AppSpacing.pillBorderRadius,
                        ),
                      ),
                    ),

                    // Login Features

                    // Logo
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 120.0,
                      ), //Where the logo is placed, could be adjusted later
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const Image(
                              image: AssetImage('assets/images/burgerByte.png'),
                              width: 320,
                              fit: BoxFit.contain,
                            ),

                            // Username textfield
                            const SizedBox(
                              height: 100,
                            ), // Where the textfields are placed based of logo, could be adjusted later
                            CustomTextfield(
                              controller: emailController,
                              hintText: 'Email',
                              obscureText: false,
                            ),

                            // Password textfield
                            const SizedBox(
                              height: 20,
                            ), // Distance between the two textfields, could be adjusted later
                            CustomTextfield(
                              controller: passwordController,
                              hintText: 'Password',
                              obscureText: true,
                              showToggle: true,
                            ),

                            const SizedBox(
                              height: 10,
                            ), // Distance between the "Forgot password?" text and the error message, could be adjusted later
                            Text(
                              errorMessage,
                              style: TextStyle(
                                color: AppColors.gold,
                                fontFamily: 'Jersey20',
                                fontSize: 16,
                              ),
                            ),

                            // Forgot password?
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30.0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () => Navigator.pushNamed(
                                      context,
                                      '/forgot-password',
                                    ), // Temporary does nothing, will be changed later to actually take the user to the forgot password page
                                    style: ButtonStyle(
                                      padding: WidgetStateProperty.all(
                                        EdgeInsets.zero,
                                      ),
                                      minimumSize: WidgetStateProperty.all(
                                        Size.zero,
                                      ),
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      overlayColor:
                                          WidgetStateProperty.resolveWith((
                                            states,
                                          ) {
                                            if (states.contains(
                                              WidgetState.pressed,
                                            )) {
                                              return AppColors.purple
                                                  .withValues(alpha: 0.4);
                                            }
                                            return null;
                                          }),
                                      foregroundColor:
                                          WidgetStateProperty.resolveWith((
                                            states,
                                          ) {
                                            if (states.contains(
                                              WidgetState.pressed,
                                            )) {
                                              return AppColors.gold;
                                            }
                                            return AppColors.cream;
                                          }),
                                    ),
                                    child: Text(
                                      'Forgot password?',
                                      style: TextStyle(
                                        fontFamily: 'Jersey20',
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Login button
                            const SizedBox(
                              height: 40,
                            ), // Distance between the "Forgot password?" text and the login button, could be adjusted later
                            CustomButton(
                              text: 'Login',
                              onTap: () =>
                                  signUserIn(), // Temporary does nothing until AUTH is implemented
                            ),
                            // Not a member? Register now "Text Button"
                            const SizedBox(
                              height: 10,
                            ), // Distance between the logi button and the Divider, could be adjusted later
                            Divider(
                              color: AppColors.cream.withValues(alpha: 0.2),
                              thickness: 1,
                              indent: 60,
                              endIndent: 60,
                            ),
                            const SizedBox(
                              height: 5,
                            ), // Distance between the Divider and the "Not a member? Register now" text, could be adjusted later
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30.0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Not a member?',
                                    style: TextStyle(
                                      color: AppColors.cream,
                                      fontFamily: 'Jersey20',
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(width: 4),

                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/signup');
                                    },
                                    style: ButtonStyle(
                                      padding: WidgetStateProperty.all(
                                        EdgeInsets.zero,
                                      ),
                                      minimumSize: WidgetStateProperty.all(
                                        Size.zero,
                                      ),
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      overlayColor:
                                          WidgetStateProperty.resolveWith((
                                            states,
                                          ) {
                                            if (states.contains(
                                              WidgetState.pressed,
                                            )) {
                                              return AppColors.purple
                                                  .withValues(alpha: 0.4);
                                            }
                                            return null;
                                          }),
                                      foregroundColor:
                                          WidgetStateProperty.resolveWith((
                                            states,
                                          ) {
                                            if (states.contains(
                                              WidgetState.pressed,
                                            )) {
                                              return AppColors.cream;
                                            }
                                            return AppColors.gold;
                                          }),
                                    ),
                                    child: Text(
                                      'Register now',
                                      style: TextStyle(
                                        fontFamily: 'Jersey20',
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
