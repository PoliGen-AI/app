import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'shared_form_components.dart';

// Password Strength Indicator Component
class PasswordStrengthIndicator extends StatelessWidget {
  final String password;

  const PasswordStrengthIndicator({super.key, required this.password});

  PasswordStrength _calculateStrength() {
    int score = 0;

    // Length check
    if (password.length >= 8) score++;
    if (password.length >= 12) score++;

    // Character variety checks
    if (RegExp(r'[a-z]').hasMatch(password)) score++;
    if (RegExp(r'[A-Z]').hasMatch(password)) score++;
    if (RegExp(r'[0-9]').hasMatch(password)) score++;
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) score++;

    if (score <= 2) return PasswordStrength.weak;
    if (score <= 4) return PasswordStrength.medium;
    return PasswordStrength.strong;
  }

  @override
  Widget build(BuildContext context) {
    // Only show indicator when there's text
    if (password.isEmpty) {
      return const SizedBox.shrink();
    }

    final strength = _calculateStrength();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2A2A),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: strength == PasswordStrength.weak
                      ? 0.33
                      : strength == PasswordStrength.medium
                      ? 0.66
                      : 1.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: strength == PasswordStrength.weak
                          ? const Color(0xFFEF4444) // Red
                          : strength == PasswordStrength.medium
                          ? const Color(0xFFF59E0B) // Yellow/Orange
                          : const Color(0xFF10B981), // Green
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              strength == PasswordStrength.weak
                  ? 'Fraca'
                  : strength == PasswordStrength.medium
                  ? 'Média'
                  : 'Forte',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: strength == PasswordStrength.weak
                    ? const Color(0xFFEF4444)
                    : strength == PasswordStrength.medium
                    ? const Color(0xFFF59E0B)
                    : const Color(0xFF10B981),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          _getRequirementsText(),
          style: GoogleFonts.inter(
            fontSize: 13,
            color: const Color(0xFF6B7280),
            height: 1.4,
          ),
        ),
      ],
    );
  }

  String _getRequirementsText() {
    List<String> requirements = [];

    if (password.length < 8) {
      requirements.add('• Pelo menos 8 caracteres');
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      requirements.add('• Uma letra maiúscula');
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      requirements.add('• Uma letra minúscula');
    }
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      requirements.add('• Um número');
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      requirements.add('• Um caractere especial');
    }

    return requirements.isEmpty ? '✓ Senha segura!' : requirements.join('\n');
  }
}

enum PasswordStrength { weak, medium, strong }

/// Example showing how to create a registration form using shared components
/// This demonstrates reusability across different pages

// Example of how to create a registration page using the same components
class RegistrationForm extends StatefulWidget {
  final VoidCallback? onBackToLogin;

  const RegistrationForm({super.key, this.onBackToLogin});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formChildren = [
      // Title section
      const FormTitle(title: 'Criar conta', subtitle: 'Junte-se ao Poligen'),
      const SizedBox(height: 20),

      // Registration fields
      const FormTextField(
        label: 'Nome completo',
        hintText: 'Digite seu nome completo',
      ),
      const SizedBox(height: 12),

      const FormTextField(
        label: 'E-mail',
        hintText: 'Digite seu e-mail',
        keyboardType: TextInputType.emailAddress,
      ),
      const SizedBox(height: 12),

      FormTextField(
        label: 'Senha',
        hintText: 'Digite sua senha',
        obscureText: true,
        controller: _passwordController,
        onChanged: (value) => setState(() {}),
      ),
      PasswordStrengthIndicator(password: _passwordController.text),
      const SizedBox(height: 12),

      const FormTextField(
        label: 'Confirmar senha',
        hintText: 'Digite sua senha novamente',
        obscureText: true,
      ),
      const SizedBox(height: 16),

      // Register button
      PrimaryButton(
        text: 'Criar conta',
        onPressed: () {
          // Navigate back to login or show success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Conta criada com sucesso!'),
              backgroundColor: Color(0xFF75152F),
            ),
          );
          // Optionally navigate back to login after a delay
          Future.delayed(const Duration(seconds: 2), () {
            if (context.mounted) {
              Navigator.of(context).pop();
            }
          });
        },
      ),
      const SizedBox(height: 12),

      const FormDivider(text: 'Ou continue com'),
      const SizedBox(height: 12),

      // Social login buttons
      SecondaryButton(
        text: 'Continuar com Google',
        onPressed: () {
          print('Google registration pressed');
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

      // Footer
      FormFooter(
        primaryText: "Já tem uma conta?",
        actionText: "Fazer login",
        onActionPressed:
            widget.onBackToLogin ??
            () {
              Navigator.of(context).pop();
            },
      ),
    ];

    return FormContainer(children: formChildren);
  }
}

// Example of a password reset form
class PasswordResetForm extends StatelessWidget {
  const PasswordResetForm({super.key});

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
          print('Send reset instructions');
        },
      ),
      const SizedBox(height: 16),

      FormFooter(
        primaryText: "Lembrou sua senha?",
        actionText: "Voltar ao login",
        onActionPressed: () {
          print('Navigate to login');
        },
      ),
    ];

    return FormContainer(children: formChildren);
  }
}
