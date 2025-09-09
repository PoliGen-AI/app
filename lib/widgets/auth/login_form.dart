import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'shared_form_components.dart';
import '../../forgot_password_page.dart';

class LoginForm extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Widget> children;
  final VoidCallback? onLoginPressed;
  final VoidCallback? onGooglePressed;
  final VoidCallback? onCreateAccountPressed;
  final bool showDefaultFields;

  const LoginForm({
    super.key,
    this.title = 'Bem-vindo de volta',
    this.subtitle = 'Entre no Poligen',
    this.children = const [],
    this.onLoginPressed,
    this.onGooglePressed,
    this.onCreateAccountPressed,
    this.showDefaultFields = true,
  });

  @override
  Widget build(BuildContext context) {
    final formChildren = <Widget>[
      FormTitle(title: title, subtitle: subtitle),
      const SizedBox(height: 16),

      ...children,
      if (showDefaultFields && children.isEmpty) ...[
        const FormTextField(label: 'E-mail', hintText: 'Digite seu e-mail'),
        const SizedBox(height: 12),
        const FormTextField(
          label: 'Senha',
          hintText: 'Digite sua senha',
          obscureText: true,
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ForgotPasswordPage(),
                  ),
                );
              },
              child: Text(
                'Esqueceu a senha?',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF94A3B8),
                  decoration: TextDecoration.underline,
                  decorationColor: const Color(0xFF94A3B8),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        PrimaryButton(
          text: 'Entrar',
          onPressed:
              onLoginPressed ??
              () {
                print('Login button pressed');
              },
        ),
        const SizedBox(height: 12),
        const FormDivider(text: 'Ou continue com'),
        const SizedBox(height: 12),
        SecondaryButton(
          text: 'Entrar com Google',
          onPressed:
              onGooglePressed ??
              () {
                print('Google login pressed');
              },
          leadingIcon: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2),
            ),
            child: const Center(
              child: Text(
                'G',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        FormFooter(
          primaryText: "Não tem uma conta?",
          actionText: "Criar conta",
          onActionPressed:
              onCreateAccountPressed ??
              () {
                print('Create account pressed');
              },
        ),
      ],
    ];

    return FormContainer(children: formChildren);
  }
}

class LoginTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  const LoginTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF94A3B8),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF404040), width: 1),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            onChanged: onChanged,
            style: GoogleFonts.inter(fontSize: 16, color: Colors.white),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: GoogleFonts.inter(
                fontSize: 16,
                color: const Color(0xFF6B7280),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
