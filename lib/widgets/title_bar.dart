import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class CustomTitleBar extends StatelessWidget {
  const CustomTitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Window drag area at the top (invisible but functional)
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 40, // Height of the draggable area
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onPanStart: (details) {
              windowManager.startDragging();
            },
            onPanUpdate: (details) {
              // Window manager handles the dragging
            },
            child: Container(color: Colors.transparent),
          ),
        ),
        // Window controls at the top
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.only(top: 8, right: 8),
            child: Row(
              children: [
                // Minimize button
                IconButton(
                  icon: Icon(Icons.minimize, color: Colors.white, size: 16),
                  onPressed: () => windowManager.minimize(),
                  padding: EdgeInsets.all(8),
                  constraints: BoxConstraints(),
                ),
                // Close button
                IconButton(
                  icon: Icon(Icons.close, color: Colors.white, size: 16),
                  onPressed: () => windowManager.close(),
                  padding: EdgeInsets.all(8),
                  constraints: BoxConstraints(),
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
