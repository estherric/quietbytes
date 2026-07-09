import 'package:flutter/material.dart';
import 'package:quietbytes/app/auth_service.dart';
import 'package:quietbytes/components/mainshell.dart';
import 'package:quietbytes/features/welcome.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({super.key, this.pageIfNotConnected});

  final Widget? pageIfNotConnected;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: authService,
      builder: (context, authService, child) {
        return StreamBuilder(
          stream: authService.authStateChanges(),
          builder: (context, snapshot) {
            Widget widget;
            if (snapshot.connectionState == ConnectionState.waiting) {
              widget = const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            } else if (snapshot.hasData) {
              widget = const MainShell();
            } else {
              widget = pageIfNotConnected ?? const Welcome();
            }
            return widget;
          },
        );
      },
    );
  }
}
