import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/user_model.dart';

class ProfileModal extends StatelessWidget {
  final User user;
  final VoidCallback? onClose;
  final VoidCallback? onEditProfile;

  const ProfileModal({
    super.key,
    required this.user,
    this.onClose,
    this.onEditProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        width: 550, // Increased width for better display
        constraints: const BoxConstraints(
          maxWidth: 600,
          maxHeight: 700,
        ), // Increased max height
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A).withOpacity(0.95),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.15), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 30,
              spreadRadius: 10,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header with close button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Perfil',
                    style: GoogleFonts.inter(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: onClose ?? () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close,
                      color: Colors.white.withOpacity(0.7),
                      size: 28,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Profile image and basic info
              _buildProfileHeader(),

              const SizedBox(height: 32),

              // Profile details in a grid layout
              _buildProfileDetails(),

              const SizedBox(height: 40),

              // Action buttons
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        // Profile avatar
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: user.avatarUrl != null
                ? null
                : const LinearGradient(
                    colors: [Color(0xFFFF6B9D), Color(0xFFE91E63)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
            image: user.avatarUrl != null
                ? DecorationImage(
                    image: NetworkImage(user.avatarUrl!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: user.avatarUrl == null
              ? const Icon(Icons.person, color: Colors.white, size: 50)
              : null,
        ),

        const SizedBox(height: 16),

        // Name
        Text(
          user.name,
          style: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 4),

        // Email
        Text(
          user.email,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.white.withOpacity(0.7),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildProfileDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // User ID
        _buildCompactInfoRow('ID do Usuário', user.id),

        const SizedBox(height: 24),

        // Bio section
        if (user.bio != null && user.bio!.isNotEmpty) ...[
          _buildDetailSection(title: 'Sobre', content: user.bio!),
          const SizedBox(height: 24),
        ],

        // Two-column layout for stats and join date
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Statistics column
            Expanded(
              child: _buildDetailSection(
                title: 'Imagens Geradas',
                content: '${user.imagesGenerated}',
              ),
            ),
            const SizedBox(width: 24),
            // Join date column
            Expanded(
              child: user.joinDate != null
                  ? _buildDetailSection(
                      title: 'Membro Desde',
                      content: _formatJoinDate(user.joinDate!),
                    )
                  : _buildDetailSection(
                      title: 'Status',
                      content: 'Membro Ativo',
                    ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // Additional info section
        _buildAdditionalInfoSection(),
      ],
    );
  }

  Widget _buildCompactInfoRow(String label, String value) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white.withOpacity(0.7),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.white.withOpacity(0.9),
            ).copyWith(fontFamily: 'Courier'), // Use monospace-like font for ID
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailSection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Text(
            content,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.white,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAdditionalInfoSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Informações Adicionais',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.verified_user,
                color: const Color(0xFFFF6B9D),
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                'Conta Verificada',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.photo_camera,
                color: const Color(0xFFFF6B9D),
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                'Geração de Imagens Ativa',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        // Edit Profile Button
        Expanded(
          child: Container(
            height: 44,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: TextButton.icon(
              onPressed:
                  onEditProfile ??
                  () {
                    // TODO: Navigate to edit profile screen
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Funcionalidade de edição em breve!'),
                        backgroundColor: Color(0xFF75152F),
                      ),
                    );
                  },
              icon: Icon(
                Icons.edit,
                color: Colors.white.withOpacity(0.8),
                size: 18,
              ),
              label: Text(
                'Editar Perfil',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(width: 12),

        // Close Button
        Container(
          height: 44,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF75152F), Color(0xFFCF1745), Color(0xFFFF2E62)],
              stops: [0.0232, 0.5043, 0.9855],
              begin: Alignment(-1.0, 0.0),
              end: Alignment(1.0, 0.0),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ElevatedButton(
            onPressed: onClose ?? () => Navigator.of(context).pop(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20),
            ),
            child: Text(
              'Fechar',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _formatJoinDate(DateTime joinDate) {
    final months = [
      'janeiro',
      'fevereiro',
      'março',
      'abril',
      'maio',
      'junho',
      'julho',
      'agosto',
      'setembro',
      'outubro',
      'novembro',
      'dezembro',
    ];

    return '${joinDate.day} de ${months[joinDate.month - 1]} de ${joinDate.year}';
  }
}
