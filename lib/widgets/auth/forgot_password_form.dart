import 'package:flutter/material.dart';
import 'shared_form_components.dart';

class ForgotPasswordForm extends StatelessWidget {
  final VoidCallback? onBackToLogin;

  const ForgotPasswordForm({super.key, this.onBackToLogin});

  @override
  Widget build(BuildContext context) {
    final formChildren = [
      // Title section
      const FormTitle(
        title: 'Redefinir senha',
        subtitle: 'Digite seu e-mail para receber instruções',
      ),
      const SizedBox(height: 20),

      // Email field
      const FormTextField(
        label: 'E-mail',
        hintText: 'Digite seu e-mail',
        keyboardType: TextInputType.emailAddress,
      ),
      const SizedBox(height: 16),

      // Send instructions button
      PrimaryButton(
        text: 'Enviar instruções',
        onPressed: () {
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Instruções enviadas para seu e-mail!'),
              backgroundColor: Color(0xFF75152F),
            ),
          );
          // Optionally navigate back after a delay
          Future.delayed(const Duration(seconds: 2), () {
            if (context.mounted) {
              Navigator.of(context).pop();
            }
          });
        },
      ),
      const SizedBox(height: 16),

      // Footer
      FormFooter(
        primaryText: "Lembrou sua senha?",
        actionText: "Voltar ao login",
        onActionPressed:
            onBackToLogin ??
            () {
              Navigator.of(context).pop();
            },
      ),
    ];

    return FormContainer(children: formChildren);
  }
}
