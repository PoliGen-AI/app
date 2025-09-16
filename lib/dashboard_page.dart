import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:poligen_app/widgets/widgets.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final TextEditingController _promptController = TextEditingController();
  final TextEditingController _negativePromptController =
      TextEditingController();

  late String _selectedStyle;
  late String _selectedAspectRatio;
  double _diffusionSteps = 20;
  late String _selectedSeed;
  late String _selectedQuantity;

  @override
  void initState() {
    super.initState();
    _promptController.text = '';
    _negativePromptController.text = '';

    // Initialize with proper capitalized values
    _selectedStyle = 'Realista';
    _selectedAspectRatio = 'Quadrado (1:1)';
    _selectedSeed = 'Aleatório';
    _selectedQuantity = '1 Imagem';

    print('Dashboard initialized with values:');
    print('  _selectedStyle: $_selectedStyle');
    print('  _selectedAspectRatio: $_selectedAspectRatio');
    print('  _selectedSeed: $_selectedSeed');
    print('  _selectedQuantity: $_selectedQuantity');
  }

  @override
  void dispose() {
    _promptController.dispose();
    _negativePromptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuroraBackground(
        child: Stack(
          children: [
            const CustomTitleBar(),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isWideScreen = constraints.maxWidth > 700;

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildHeader(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: isWideScreen
                              ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: _buildMainContent(),
                                    ),
                                    const SizedBox(width: 24),
                                    _buildSidebar(),
                                  ],
                                )
                              : Column(
                                  children: [
                                    _buildMainContent(),
                                    const SizedBox(height: 24),
                                    _buildSidebar(),
                                  ],
                                ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
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
            child: const Icon(
              Icons.auto_awesome,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            'PoliGen',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 48),
          _buildNavButton('Início', true),
          const SizedBox(width: 24),
          _buildNavButton('Galeria', false),
          const Spacer(),
          _buildUserControl('Configurações', Icons.settings),
          const SizedBox(width: 16),
          _buildUserControl('Perfil', Icons.person),
          const SizedBox(width: 16),
          _buildUserControl('Sair', Icons.logout),
        ],
      ),
    );
  }

  Widget _buildNavButton(String text, bool isActive) {
    return TextButton(
      onPressed: () {},
      child: Text(
        text,
        style: TextStyle(
          color: isActive ? const Color(0xFFFF6B9D) : Colors.white70,
          fontSize: 16,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildUserControl(String text, IconData icon) {
    return TextButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: Colors.white70, size: 16),
      label: Text(
        text,
        style: const TextStyle(color: Colors.white70, fontSize: 14),
      ),
    );
  }

  Widget _buildMainContent() {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 400, maxWidth: 800),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageGenerationSection(),
            const SizedBox(height: 32),
            _buildResultSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageGenerationSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Gerar nova imagem',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _promptController,
            maxLines: 3,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.black.withOpacity(0.5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              hintText:
                  'Digite uma descrição detalhada da imagem que deseja gerar...',
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _negativePromptController,
            maxLines: 2,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.black.withOpacity(0.5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              hintText: 'Digite elementos que não deseja na imagem...',
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _buildDropdown('Estilo', _selectedStyle, [
                  'Realista',
                  'Anime',
                  'Cartoon',
                  'Pintura',
                ]),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildDropdown('Proporção', _selectedAspectRatio, [
                  'Quadrado (1:1)',
                  'Retrato (3:4)',
                  'Paisagem (4:3)',
                ]),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildSlider()),
              const SizedBox(width: 16),
              Expanded(
                child: _buildDropdown('Seed', _selectedSeed, [
                  'Aleatório',
                  'Fixo',
                ]),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildDropdown('Quantidade', _selectedQuantity, [
            '1 Imagem',
            '2 Imagens',
            '4 Imagens',
          ]),
          const SizedBox(height: 32),
          Container(
            width: double.infinity,
            height: 44,
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
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.auto_awesome, color: Colors.white),
                  const SizedBox(width: 12),
                  Text(
                    'Gerar imagem',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(String label, String value, List<String> options) {
    // Debug: Check if value exists in options
    if (!options.contains(value)) {
      print(
        'ERROR: Dropdown value "$value" not found in options: $options for label: $label',
      );
      // Fallback to first option if value not found
      if (options.isNotEmpty) {
        value = options.first;
        // Update the state variable
        switch (label) {
          case 'Estilo':
            _selectedStyle = value;
            break;
          case 'Proporção':
            _selectedAspectRatio = value;
            break;
          case 'Seed':
            _selectedSeed = value;
            break;
          case 'Quantidade':
            _selectedQuantity = value;
            break;
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Colors.black87,
              popupMenuTheme: PopupMenuThemeData(
                color: Colors.black87,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 8,
              ),
            ),
            child: DropdownButton<String>(
              key: ValueKey('$label-$value'),
              value: value,
              isExpanded: true,
              underline: const SizedBox(),
              dropdownColor: Colors.black87,
              style: const TextStyle(color: Colors.white),
              borderRadius: BorderRadius.circular(16),
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
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    switch (label) {
                      case 'estilo':
                        _selectedStyle = newValue;
                        break;
                      case 'proporção':
                        _selectedAspectRatio = newValue;
                        break;
                      case 'seed':
                        _selectedSeed = newValue;
                        break;
                      case 'quantidade':
                        _selectedQuantity = newValue;
                        break;
                    }
                  });
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Passos de difusão: ${_diffusionSteps.round()}',
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Slider(
            value: _diffusionSteps,
            min: 10,
            max: 50,
            divisions: 8,
            activeColor: const Color(0xFFFF6B9D),
            inactiveColor: Colors.white.withOpacity(0.3),
            onChanged: (double value) {
              setState(() {
                _diffusionSteps = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildResultSection() {
    return Container(
      width: double.infinity,
      height: 400,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          style: BorderStyle.solid,
          strokeAlign: BorderSide.strokeAlignInside,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Resultado',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 32),
          CustomPaint(
            painter: _DashedBorderPainter(
              color: Colors.white.withOpacity(0.3),
              strokeWidth: 2,
              gap: 5,
            ),
            child: Container(
              width: double.infinity,
              height: 280,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.image_outlined,
                    color: Colors.white.withOpacity(0.5),
                    size: 64,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Sua imagem aparecerá aqui',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 320, maxWidth: 320),
      child: Container(
        width: 320,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRecentImagesSection(),
            const SizedBox(height: 32),
            _buildStatisticsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentImagesSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Imagens recentes',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: Icon(
                    Icons.image_outlined,
                    color: Colors.white.withOpacity(0.3),
                    size: 32,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {},
              child: const Text(
                'Ver todas as imagens',
                style: TextStyle(color: Color(0xFFFF6B9D), fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Estatísticas',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildStatItem('Imagens geradas', '24'),
          const SizedBox(height: 12),
          _buildStatItem('Imagens salvas', '10'),
          const SizedBox(height: 12),
          _buildStatItem('Favoritas', '12'),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFFFF6B9D),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;

  _DashedBorderPainter({
    required this.color,
    this.strokeWidth = 1,
    this.gap = 5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final double dashWidth = 8;
    final double cornerRadius = 12;

    // Create a rounded rectangle path
    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(cornerRadius),
    );

    // Draw dashed border
    final Path path = Path()..addRRect(rrect);
    final Path dashPath = Path();

    for (ui.PathMetric pathMetric in path.computeMetrics()) {
      double distance = 0;
      bool draw = true;

      while (distance < pathMetric.length) {
        final double length = draw ? dashWidth : gap;
        if (draw) {
          final ui.Tangent? tangent = pathMetric.getTangentForOffset(distance);
          if (tangent != null) {
            final ui.Tangent? nextTangent = pathMetric.getTangentForOffset(
              distance + dashWidth,
            );
            if (nextTangent != null) {
              dashPath.moveTo(tangent.position.dx, tangent.position.dy);
              dashPath.lineTo(nextTangent.position.dx, nextTangent.position.dy);
            }
          }
        }
        distance += length;
        draw = !draw;
      }
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(_DashedBorderPainter oldDelegate) {
    return color != oldDelegate.color ||
        strokeWidth != oldDelegate.strokeWidth ||
        gap != oldDelegate.gap;
  }
}
