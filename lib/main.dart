import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:flutter/material.dart';
import 'package:quietbytes/components/mainshell.dart';
import 'features/login.dart';
import 'features/signup.dart';
import 'features/welcome.dart';
import 'features/test.dart';
import '../features/settings.dart';
import '../features/settings_change_username.dart';
import '../features/settings_change_email.dart';
import '../features/settings_change_password.dart';
import '../app/auth_layout.dart';
import 'features/forgot_password.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/auth',
      routes: {
        '/test': (context) =>
            const Test(), // For testing purposes, can be removed later
        '/auth': (context) => const AuthLayout(),
        '/welcome': (context) => Welcome(),
        '/login': (context) => Login(),
        '/forgot-password': (context) => ForgotPassword(),
        '/signup': (context) => Signup(),
        '/home': (context) => const MainShell(),
        '/settings': (context) => Settings(),
        '/settings/change-username': (context) => SettingsChangeUsername(),
        '/settings/change-email': (context) => SettingsChangeEmail(),
        '/settings/change-password': (context) => SettingsChangePassword(),
      },
    );
  }
}
