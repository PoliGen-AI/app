import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import '../services/notification_service.dart';

class CustomTitleBar extends StatelessWidget {
  const CustomTitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Widget para arrastar a janela (está correto, não precisa mudar)
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 40,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onPanStart: (details) {
              windowManager.startDragging();
            },
            child: Container(color: Colors.transparent),
          ),
        ),
        // Botões de controle da janela
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.only(top: 8, right: 8),
            child: Row(
              children: [
                // Botão de Minimizar (está correto)
                IconButton(
                  icon: const Icon(
                    Icons.minimize,
                    color: Colors.white,
                    size: 16,
                  ),
                  onPressed: () => windowManager.minimize(),
                  padding: const EdgeInsets.all(8),
                  constraints: const BoxConstraints(),
                ),

                // Botão de Fechar (aqui está a correção)
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 16),

                  // MUDANÇA PRINCIPAL AQUI
                  // Em vez de esconder a janela aqui, nós apenas disparamos o evento de fechar.
                  // O _WindowListener em main.dart vai cuidar do resto.
                  onPressed: () => windowManager.close(),

                  // O código antigo foi removido:
                  // onPressed: () async {
                  //   await windowManager.hide();
                  //   debugPrint('...');
                  // },
                  padding: const EdgeInsets.all(8),
                  constraints: const BoxConstraints(),
                  hoverColor: Colors.red.withOpacity(0.3),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
