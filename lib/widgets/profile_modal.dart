import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/user_model.dart';

class ProfileModal extends StatefulWidget {
  final User user;
  final VoidCallback? onClose;
  final ValueChanged<User>? onUserUpdated;

  const ProfileModal({
    super.key,
    required this.user,
    this.onClose,
    this.onUserUpdated,
  });

  @override
  State<ProfileModal> createState() => _ProfileModalState();
}

class _ProfileModalState extends State<ProfileModal> {
  bool _isEditMode = false;
  bool _isLoading = false;

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _bioController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
    _bioController = TextEditingController(text: widget.user.bio ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        width: 550,
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 700),
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
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeader(),
                const SizedBox(height: 32),
                _isEditMode ? _buildEditContent() : _buildViewContent(),
                const SizedBox(height: 40),
                _buildActionButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _isEditMode ? 'Editar Perfil' : 'Perfil',
          style: GoogleFonts.inter(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        Row(
          children: [
            if (!_isEditMode)
              IconButton(
                onPressed: () => setState(() => _isEditMode = true),
                icon: Icon(
                  Icons.edit,
                  color: const Color(0xFFFF6B9D),
                  size: 24,
                ),
                tooltip: 'Editar perfil',
              ),
            IconButton(
              onPressed: widget.onClose ?? () => Navigator.of(context).pop(),
              icon: Icon(
                Icons.close,
                color: Colors.white.withOpacity(0.7),
                size: 28,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildViewContent() {
    return Column(
      children: [
        // Profile image and basic info
        _buildProfileHeader(),

        const SizedBox(height: 32),

        // Profile details
        _buildProfileDetails(),
      ],
    );
  }

  Widget _buildProfileImageSection() {
    return Center(
      child: Column(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: widget.user.avatarUrl != null
                  ? null
                  : const LinearGradient(
                      colors: [Color(0xFFFF6B9D), Color(0xFFE91E63)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
              image: widget.user.avatarUrl != null
                  ? DecorationImage(
                      image: NetworkImage(widget.user.avatarUrl!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: widget.user.avatarUrl == null
                ? const Icon(Icons.person, color: Colors.white, size: 60)
                : null,
          ),
          const SizedBox(height: 16),
          TextButton.icon(
            onPressed: _changeProfileImage,
            icon: Icon(
              Icons.camera_alt,
              color: const Color(0xFFFF6B9D),
              size: 18,
            ),
            label: Text(
              'Alterar foto',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFFF6B9D),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField(
          controller: _nameController,
          label: 'Nome',
          hintText: 'Digite seu nome completo',
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Nome é obrigatório';
            }
            if (value.trim().length < 2) {
              return 'Nome deve ter pelo menos 2 caracteres';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        _buildTextField(
          controller: _emailController,
          label: 'E-mail',
          hintText: 'Digite seu e-mail',
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'E-mail é obrigatório';
            }
            final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
            if (!emailRegex.hasMatch(value.trim())) {
              return 'Digite um e-mail válido';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        _buildTextField(
          controller: _bioController,
          label: 'Biografia',
          hintText: 'Conte um pouco sobre você...',
          maxLines: 4,
          validator: (value) {
            if (value != null && value.length > 500) {
              return 'Biografia deve ter no máximo 500 caracteres';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            maxLines: maxLines,
            style: GoogleFonts.inter(fontSize: 16, color: Colors.white),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: GoogleFonts.inter(
                fontSize: 16,
                color: Colors.white.withOpacity(0.5),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              border: InputBorder.none,
              errorStyle: GoogleFonts.inter(
                fontSize: 12,
                color: const Color(0xFFFF6B9D),
              ),
            ),
            validator: validator,
            onChanged: (value) {
              if (controller == _bioController) {
                setState(() {}); // Update character count
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEditContent() {
    return Column(
      children: [
        // Profile image section
        _buildProfileImageSection(),

        const SizedBox(height: 32),

        // Form fields
        _buildFormFields(),

        const SizedBox(height: 8),

        // Character counter for bio
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            '${_bioController.text.length}/500',
            style: GoogleFonts.inter(
              fontSize: 12,
              color: Colors.white.withOpacity(0.6),
            ),
          ),
        ),
      ],
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
            gradient: widget.user.avatarUrl != null
                ? null
                : const LinearGradient(
                    colors: [Color(0xFFFF6B9D), Color(0xFFE91E63)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
            image: widget.user.avatarUrl != null
                ? DecorationImage(
                    image: NetworkImage(widget.user.avatarUrl!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: widget.user.avatarUrl == null
              ? const Icon(Icons.person, color: Colors.white, size: 50)
              : null,
        ),

        const SizedBox(height: 16),

        // Name
        Text(
          widget.user.name,
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
          widget.user.email,
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
        _buildCompactInfoRow('ID do Usuário', widget.user.id),

        const SizedBox(height: 24),

        // Bio section
        if (widget.user.bio != null && widget.user.bio!.isNotEmpty) ...[
          _buildDetailSection(title: 'Sobre', content: widget.user.bio!),
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
                content: '${widget.user.imagesGenerated}',
              ),
            ),
            const SizedBox(width: 24),
            // Join date column
            Expanded(
              child: widget.user.joinDate != null
                  ? _buildDetailSection(
                      title: 'Membro Desde',
                      content: _formatJoinDate(widget.user.joinDate!),
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

  Widget _buildActionButtons() {
    if (_isEditMode) {
      return Row(
        children: [
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
              ),
              child: TextButton(
                onPressed: _isLoading ? null : _cancelEdit,
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white.withOpacity(0.8),
                ),
                child: Text(
                  'Cancelar',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF75152F),
                    Color(0xFFCF1745),
                    Color(0xFFFF2E62),
                  ],
                  stops: [0.0232, 0.5043, 0.9855],
                  begin: Alignment(-1.0, 0.0),
                  end: Alignment(1.0, 0.0),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ElevatedButton(
                onPressed: _isLoading ? null : _saveProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                    : Text(
                        'Salvar',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF75152F),
                    Color(0xFFCF1745),
                    Color(0xFFFF2E62),
                  ],
                  stops: [0.0232, 0.5043, 0.9855],
                  begin: Alignment(-1.0, 0.0),
                  end: Alignment(1.0, 0.0),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ElevatedButton(
                onPressed: widget.onClose ?? () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Fechar',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
  }

  void _cancelEdit() {
    setState(() {
      _isEditMode = false;
      // Reset form fields to original values
      _nameController.text = widget.user.name;
      _emailController.text = widget.user.email;
      _bioController.text = widget.user.bio ?? '';
    });
  }

  void _saveProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 2));

      final updatedUser = widget.user.copyWith(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        bio: _bioController.text.trim().isEmpty
            ? null
            : _bioController.text.trim(),
      );

      if (mounted) {
        widget.onUserUpdated?.call(updatedUser);
        setState(() {
          _isEditMode = false;
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Perfil atualizado com sucesso!'),
            backgroundColor: Color(0xFF75152F),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro ao salvar perfil. Tente novamente.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _changeProfileImage() {
    // TODO: Implement image picker functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Funcionalidade de alteração de foto em breve!'),
        backgroundColor: Color(0xFF75152F),
      ),
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
