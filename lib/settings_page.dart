import 'package:flutter/material.dart';
import 'package:poligen_app/widgets/widgets.dart';
import 'package:poligen_app/services/settings_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final SettingsService _settingsService = SettingsService();

  @override
  void initState() {
    super.initState();
    _settingsService.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuroraBackground(
        child: AnimatedBuilder(
          animation: _settingsService,
          builder: (context, child) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 40.0,
                  left: 24.0,
                  right: 24.0,
                  bottom: 24.0,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 32),
                      _buildThemeSection(),
                      const SizedBox(height: 24),
                      _buildCookiesSection(),
                      const SizedBox(height: 24),
                      _buildPrivacySection(),
                      const SizedBox(height: 24),
                      _buildGeneralSection(),
                      const SizedBox(height: 24),
                      _buildImageSection(),
                      const SizedBox(height: 32),
                      _buildActionButtons(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back,
            color: isDarkTheme ? Colors.white70 : Colors.black54,
          ),
        ),
        const SizedBox(width: 12),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [Color(0xFFFF6B9D), Color(0xFFE91E63)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Icon(Icons.settings, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          'Configurações',
          style: TextStyle(
            color: isDarkTheme ? Colors.white : Colors.black87,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
      ],
    );
  }

  Widget _buildThemeSection() {
    return _buildSection(
      title: 'Aparência',
      icon: Icons.palette,
      children: [
        _buildSwitchTile(
          title: 'Tema escuro',
          subtitle: 'Ativar tema escuro da interface',
          value: _settingsService.isDarkTheme,
          onChanged: (value) {
            _settingsService.updateTheme(value);
          },
        ),
      ],
    );
  }

  Widget _buildCookiesSection() {
    return _buildSection(
      title: 'Cookies e Privacidade',
      icon: Icons.cookie,
      children: [
        _buildInfoTile(
          'Os cookies ajudam a melhorar sua experiência no PoliGen. Você pode escolher quais tipos de cookies aceitar.',
        ),
        const SizedBox(height: 16),
        _buildSwitchTile(
          title: 'Cookies essenciais',
          subtitle: 'Necessários para o funcionamento básico do app',
          value: _settingsService.essentialCookies,
          onChanged: (value) {
            _settingsService.updateEssentialCookies(value);
          },
          enabled: true, // Always enabled
        ),
        _buildSwitchTile(
          title: 'Cookies funcionais',
          subtitle: 'Lembram suas preferências e configurações',
          value: _settingsService.functionalCookies,
          onChanged: _settingsService.essentialCookies
              ? (value) {
                  _settingsService.updateFunctionalCookies(value);
                }
              : null,
        ),
        _buildSwitchTile(
          title: 'Cookies de performance',
          subtitle: 'Coletam dados para melhorar a performance',
          value: _settingsService.performanceCookies,
          onChanged: _settingsService.essentialCookies
              ? (value) {
                  _settingsService.updatePerformanceCookies(value);
                }
              : null,
        ),
        _buildSwitchTile(
          title: 'Cookies de marketing',
          subtitle: 'Usados para personalizar anúncios e conteúdo',
          value: _settingsService.marketingCookies,
          onChanged: _settingsService.essentialCookies
              ? (value) {
                  _settingsService.updateMarketingCookies(value);
                }
              : null,
        ),
      ],
    );
  }

  Widget _buildPrivacySection() {
    return _buildSection(
      title: 'Privacidade e Dados',
      icon: Icons.privacy_tip,
      children: [
        _buildSwitchTile(
          title: 'Análise de uso',
          subtitle: 'Compartilhar dados anônimos para melhorar o app',
          value: _settingsService.analyticsEnabled,
          onChanged: (value) {
            _settingsService.updateAnalytics(value);
          },
        ),
        _buildSwitchTile(
          title: 'Marketing personalizado',
          subtitle: 'Receber ofertas e conteúdo personalizado',
          value: _settingsService.marketingEnabled,
          onChanged: (value) {
            _settingsService.updateMarketing(value);
          },
        ),
      ],
    );
  }

  Widget _buildGeneralSection() {
    return _buildSection(
      title: 'Geral',
      icon: Icons.settings_applications,
      children: [
        _buildSwitchTile(
          title: 'Salvamento automático',
          subtitle: 'Salvar imagens automaticamente na galeria',
          value: _settingsService.autoSave,
          onChanged: (value) {
            _settingsService.updateAutoSave(value);
          },
        ),
        _buildSwitchTile(
          title: 'Dicas e tutoriais',
          subtitle: 'Mostrar dicas e tutoriais para novos recursos',
          value: _settingsService.showTips,
          onChanged: (value) {
            _settingsService.updateShowTips(value);
          },
        ),
      ],
    );
  }

  Widget _buildImageSection() {
    return _buildSection(
      title: 'Qualidade de Imagem',
      icon: Icons.high_quality,
      children: [
        _buildDropdownTile(
          title: 'Qualidade padrão',
          subtitle: 'Escolha a qualidade padrão para geração de imagens',
          value: _settingsService.imageQuality,
          options: ['Baixa', 'Média', 'Alta', 'Máxima'],
          onChanged: (value) {
            _settingsService.updateImageQuality(value);
          },
        ),
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDarkTheme
            ? Colors.black.withOpacity(0.3)
            : Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDarkTheme
              ? Colors.white.withOpacity(0.1)
              : Colors.black.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFFFF6B9D), size: 20),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  color: isDarkTheme ? Colors.white : Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool>? onChanged,
    bool enabled = true,
  }) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkTheme
            ? Colors.black.withOpacity(0.2)
            : Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDarkTheme
              ? Colors.white.withOpacity(0.1)
              : Colors.black.withOpacity(0.1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: enabled
                        ? (isDarkTheme ? Colors.white : Colors.black87)
                        : (isDarkTheme ? Colors.white60 : Colors.black54),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: enabled
                        ? (isDarkTheme ? Colors.white70 : Colors.black54)
                        : (isDarkTheme ? Colors.white60 : Colors.black38),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: enabled ? onChanged : null,
            activeColor: const Color(0xFFFF6B9D),
            inactiveTrackColor: isDarkTheme
                ? Colors.white.withOpacity(0.2)
                : Colors.black.withOpacity(0.2),
            activeTrackColor: const Color(0xFFFF6B9D).withOpacity(0.3),
            thumbColor: MaterialStateProperty.resolveWith<Color>((states) {
              if (states.contains(MaterialState.selected)) {
                return Colors.white;
              }
              return isDarkTheme ? Colors.white70 : Colors.black54;
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownTile({
    required String title,
    required String subtitle,
    required String value,
    required List<String> options,
    required ValueChanged<String> onChanged,
  }) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkTheme
            ? Colors.black.withOpacity(0.2)
            : Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDarkTheme
              ? Colors.white.withOpacity(0.1)
              : Colors.black.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: isDarkTheme ? Colors.white : Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              color: isDarkTheme ? Colors.white70 : Colors.black54,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: isDarkTheme
                  ? Colors.black.withOpacity(0.5)
                  : Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              underline: const SizedBox(),
              dropdownColor: isDarkTheme ? Colors.black87 : Colors.white,
              style: TextStyle(
                color: isDarkTheme ? Colors.white : Colors.black87,
              ),
              items: options.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    child: Text(
                      option,
                      style: TextStyle(
                        color: isDarkTheme ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  onChanged(newValue);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile(String text) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFF6B9D).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFF6B9D).withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: const Color(0xFFFF6B9D), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              _resetToDefaults();
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white70,
              side: BorderSide(color: Colors.white.withOpacity(0.3)),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Restaurar padrões'),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Configurações salvas com sucesso!'),
                  backgroundColor: Color(0xFF4CAF50),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF6B9D),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Configurações salvas'),
          ),
        ),
      ],
    );
  }

  void _resetToDefaults() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black87,
        title: const Text(
          'Restaurar configurações padrão',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Tem certeza que deseja restaurar todas as configurações para os valores padrão? Esta ação não pode ser desfeita.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Cancelar',
              style: TextStyle(color: Colors.white70),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _settingsService.resetToDefaults();
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Configurações restauradas!'),
                  backgroundColor: Color(0xFF4CAF50),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF6B9D),
            ),
            child: const Text('Restaurar'),
          ),
        ],
      ),
    );
  }
}
