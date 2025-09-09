import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormContainer extends StatelessWidget {
  final double? width;
  final EdgeInsets padding;
  final List<Widget> children;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final BoxBorder? border;

  const FormContainer({
    super.key,
    this.width,
    this.padding = const EdgeInsets.all(16),
    required this.children,
    this.backgroundColor,
    this.borderRadius,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive width: use 85% of screen width but cap at 400px max, 320px min
    final responsiveWidth = width ?? (screenWidth * 0.85).clamp(320.0, 400.0);

    return Container(
      width: responsiveWidth,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? const Color(0xFF1A1A1A).withOpacity(0.5),
        borderRadius: borderRadius ?? BorderRadius.circular(20),
        border:
            border ??
            Border.all(
              color: const Color(0xFFFFFFFF).withOpacity(0.15),
              width: 1.5,
            ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.3),
            blurRadius: 25,
            spreadRadius: 12,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.15),
            blurRadius: 40,
            spreadRadius: 8,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }
}

class FormTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final double titleFontSize;
  final double subtitleFontSize;

  const FormTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.titleFontSize = 24,
    this.subtitleFontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: titleFontSize,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 2),
          Text(
            subtitle!,
            style: GoogleFonts.inter(
              fontSize: subtitleFontSize,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF94A3B8),
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}

class FormDivider extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Color? lineColor;

  const FormDivider({
    super.key,
    required this.text,
    this.textColor,
    this.lineColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: lineColor ?? const Color(0xFF404040),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: textColor ?? const Color(0xFF6B7280),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: lineColor ?? const Color(0xFF404040),
          ),
        ),
      ],
    );
  }
}

class FormFooter extends StatelessWidget {
  final String primaryText;
  final String actionText;
  final VoidCallback? onActionPressed;
  final Color? primaryColor;
  final Color? actionColor;

  const FormFooter({
    super.key,
    required this.primaryText,
    required this.actionText,
    this.onActionPressed,
    this.primaryColor,
    this.actionColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "$primaryText ",
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: primaryColor ?? const Color(0xFF6B7280),
          ),
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: onActionPressed ?? () {},
            child: Text(
              actionText,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: actionColor ?? const Color(0xFFFF2E62),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final String text;
  final Widget? leadingIcon;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;

  const SecondaryButton({
    super.key,
    required this.text,
    this.leadingIcon,
    this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 44,
      decoration: BoxDecoration(
        color: backgroundColor ?? const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: borderColor ?? const Color(0xFF404040),
          width: 1,
        ),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: textColor ?? Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24),
        ),
        onPressed: isLoading ? null : onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leadingIcon != null) ...[
              leadingIcon!,
              const SizedBox(width: 12),
            ],
            if (isLoading)
              const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            else
              Text(
                text,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: textColor ?? Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class FormTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  const FormTextField({
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
  State<FormTextField> createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
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
            controller: widget.controller,
            obscureText: _isObscured,
            keyboardType: widget.keyboardType,
            onChanged: widget.onChanged,
            style: GoogleFonts.inter(fontSize: 16, color: Colors.white),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: GoogleFonts.inter(
                fontSize: 16,
                color: const Color(0xFF6B7280),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              suffixIcon: widget.obscureText
                  ? IconButton(
                      icon: Icon(
                        _isObscured ? Icons.visibility_off : Icons.visibility,
                        color: const Color(0xFF94A3B8),
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscured = !_isObscured;
                        });
                      },
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final List<Color>? gradientColors;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 44,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors:
              gradientColors ??
              [
                const Color(0xFF75152F),
                const Color(0xFFCF1745),
                const Color(0xFFFF2E62),
              ],
          stops: [0.0232, 0.5043, 0.9855],
          begin: Alignment(-1.0, 0.0),
          end: Alignment(1.0, 0.0),
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF75152F).withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          padding: EdgeInsets.zero,
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                text,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
