import 'package:flutter/material.dart';
import 'dart:io';
import 'widgets/widgets.dart';
import 'widgets/auth/login_form.dart';
import 'registration_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                onPressed: () => Navigator.of(context).pop(),
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
                padding: const EdgeInsets.fromLTRB(16, 100, 16, 16),
                child: SingleChildScrollView(
                  child: Center(
                    child: LoginForm(
                      onCreateAccountPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegistrationPage(),
                          ),
                        );
                      },
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
