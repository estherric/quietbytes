import '../app/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/spacing.dart';
import '../components/custom_headers.dart';
import '../components/settings_tile.dart';
import '../components/settings_headers.dart';
import '../components/custom_button.dart';

//Rename and change Settings to whatever you want and change it in the main.dart as well, just a template if needed
//To go back to the test page, click "Template Page", you can change the name and it will still work
class Settings extends StatelessWidget {
  const Settings({super.key});

  void signUserOut(BuildContext context) async {
    try {
      await authService.value.signOut();
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/welcome',
          (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
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
              CustomHeaders(
                title: 'Settings',
                showBack: true,
                showSettings: true,
              ),

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
                      //height: AppSpacing.test,
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
                        top: 25.0,
                      ), //How far the text is from the top of the purple pill
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView(
                              children: [
                                //Profile Section
                                Center(
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 250,
                                        height: 250,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: AppColors.cream,
                                            width: 2,
                                          ),
                                        ),
                                        child: ClipOval(
                                          child: Image.asset(
                                            'assets/images/winnie.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),

                                      //-------- CHANGE PHOTO --------
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 30.0,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            TextButton(
                                              onPressed:
                                                  () {}, //ENTER LOGIC BACKEND
                                              style: ButtonStyle(
                                                padding:
                                                    WidgetStateProperty.all(
                                                      EdgeInsets.zero,
                                                    ),
                                                minimumSize:
                                                    WidgetStateProperty.all(
                                                      Size.zero,
                                                    ),
                                                tapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                                overlayColor:
                                                    WidgetStateProperty.resolveWith(
                                                      (states) {
                                                        if (states.contains(
                                                          WidgetState.pressed,
                                                        )) {
                                                          return AppColors
                                                              .purple
                                                              .withValues(
                                                                alpha: 0.4,
                                                              );
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                foregroundColor:
                                                    WidgetStateProperty.resolveWith(
                                                      (states) {
                                                        if (states.contains(
                                                          WidgetState.pressed,
                                                        )) {
                                                          return AppColors
                                                              .cream;
                                                        }
                                                        return AppColors.gold;
                                                      },
                                                    ),
                                              ),
                                              child: Text(
                                                'Change Photo',
                                                style: TextStyle(
                                                  fontFamily: 'Jersey20',
                                                  fontSize: 26,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      //ENTER BUTTON ---------
                                    ],
                                  ),
                                ),

                                //

                                // ------ START HERE To Add SETTINGS --------
                                const SizedBox(height: 10),
                                // ----- START OF ACCOUNT SETTINGS ------
                                SettingsHeaders(
                                  title: "Account Settings",
                                  icon: Icons.person,
                                ),

                                SettingsTile(
                                  title: "Change Your Username",
                                  subtitle: "subtitle",
                                  icon: Icons.home,
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    '/settings/change-username',
                                  ),
                                ),

                                SettingsTile(
                                  title: "Change Your Email",
                                  subtitle: "subtitle",
                                  icon: Icons.email,
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    '/settings/change-email',
                                  ),
                                ),

                                SettingsTile(
                                  title: "Change Your Password",
                                  subtitle: "subtitle",
                                  icon: Icons.password,
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    '/settings/change-password',
                                  ),
                                ),

                                // ----- END OF ACCOUNT SETTINGS ------
                                Divider(
                                  color: AppColors.cream.withValues(alpha: 0.4),
                                  thickness: 2,
                                  indent: AppSpacing.horizontalPaddingWidth,
                                  endIndent: AppSpacing.horizontalPaddingWidth,
                                ),
                                const SizedBox(height: 10),

                                // ---- START OF X SETTINGS ------
                                /*
                                SettingsHeaders(
                                  title: "XYZ Settings",
                                  icon: Icons.person,
                                ),

                                SettingsTile(
                                  title: "XYZ",
                                  subtitle: "subtitle",
                                  icon: Icons.home,
                                  onTap: () {},
                                ),

                                SettingsTile(
                                  title: "XYZ",
                                  subtitle: "subtitle",
                                  icon: Icons.home,
                                  onTap: () {},
                                ),
                                // ---- END OF X SETTINGS -----
                                */

                                // ------ END HERE To Add SETTINGS --------
                                CustomButton(
                                  text: 'Sign Out',
                                  onTap: () => signUserOut(context),
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
            ],
          ),
        ),
      ),
    );
  }
}
