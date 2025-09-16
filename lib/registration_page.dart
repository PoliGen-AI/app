import 'package:flutter/material.dart';
import 'dart:io';
import 'widgets/widgets.dart';
import 'widgets/auth/registration_example.dart';
import 'dashboard_page.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuroraBackground(
        child: Stack(
          children: [
            if (!Platform.isMacOS) const CustomTitleBar(),
            Positioned(
              top: 15,
              left: 15,
              child: IconButton(
                onPressed: () =>
                    Navigator.of(context).popUntil((route) => route.isFirst),
                icon: Icon(
                  Icons.arrow_back,
                  color: const Color(0xFF94A3B8),
                  size: 24,
                ),
                tooltip: 'Voltar ao início',
                padding: const EdgeInsets.all(8),
                constraints: const BoxConstraints(),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 60, 16, 16),
                child: SingleChildScrollView(
                  child: Center(
                    child: RegistrationForm(
                      onRegistrationSuccess: () {
                        // Navigate to dashboard after successful registration
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DashboardPage(),
                          ),
                          (route) => false, // Remove all previous routes
                        );
                      },
                      onBackToLogin: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
