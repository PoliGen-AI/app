import 'package:flutter/material.dart';
import 'dart:io';
import 'widgets/widgets.dart';
import 'widgets/auth/forgot_password_form.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

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
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Center(
                child: ForgotPasswordForm(
                  onBackToLogin: () => Navigator.of(context).pop(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
