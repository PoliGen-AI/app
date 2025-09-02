import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class CustomTitleBar extends StatelessWidget {
  const CustomTitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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
            onPanUpdate: (details) {},
            child: Container(color: Colors.transparent),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.only(top: 8, right: 8),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.minimize, color: Colors.white, size: 16),
                  onPressed: () => windowManager.minimize(),
                  padding: EdgeInsets.all(8),
                  constraints: BoxConstraints(),
                ),
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
