import 'package:flutter/material.dart';
import 'shared_form_components.dart';

class ForgotPasswordForm extends StatelessWidget {
  final VoidCallback? onBackToLogin;

  const ForgotPasswordForm({super.key, this.onBackToLogin});

  @override
  Widget build(BuildContext context) {
    final formChildren = [
      const FormTitle(
        title: 'Redefinir senha',
        subtitle: 'Digite seu e-mail para receber instruções',
      ),
      const SizedBox(height: 20),
      const FormTextField(
        label: 'E-mail',
        hintText: 'Digite seu e-mail',
        keyboardType: TextInputType.emailAddress,
      ),
      const SizedBox(height: 16),

      PrimaryButton(
        text: 'Enviar instruções',
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Instruções enviadas para seu e-mail!'),
              backgroundColor: Color(0xFF75152F),
            ),
          );
          Future.delayed(const Duration(seconds: 2), () {
            if (context.mounted) {
              Navigator.of(context).pop();
            }
          });
        },
      ),
      const SizedBox(height: 16),

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
