import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'widgets/widgets.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuroraBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    colors: [
                      Color(0xFF75152F),
                      Color(0xFFCF1745),
                      Color(0xFFFF2E62),
                    ],
                    stops: [0.0232, 0.5043, 0.9855],
                    begin: Alignment(-1.0, 0.0),
                    end: Alignment(1.0, 0.0),
                  ).createShader(bounds);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.sparkles,
                      size: 48,
                      color: Colors.white,
                    ),
                    SizedBox(width: 12),
                    Text(
                      'poligen',
                      style: TextStyle(
                        fontSize: 56,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Text(
                'transforme suas ideias em imagens incríveis usando inteligência artificial',
                style: TextStyle(
                  fontSize: 22,
                  color: Color(0xFF94A3B8),
                  height: 39 / 22,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF75152F),
                          Color(0xFFCF1745),
                          Color(0xFFFF2E62),
                        ],
                        stops: [0.0232, 0.5043, 0.9855],
                        begin: Alignment(-1.0, 0.0),
                        end: Alignment(1.0, 0.0),
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.only(
                          left: 32,
                          top: 14,
                          right: 32,
                          bottom: 20,
                        ),
                        alignment: Alignment.center,
                        textStyle: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Container()),
                        );
                      },
                      child: Text(
                        'entrar',
                        style: TextStyle(
                          fontSize: 18,
                          height: 28 / 18,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF18181B).withOpacity(0.8),
                      border: Border.all(
                        color: Color(0xFFED2152).withOpacity(0.3),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            foregroundColor: Color(0xFFED2152),
                            padding: EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 24,
                            ),
                            alignment: Alignment.center,
                            textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ).copyWith(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>((
                                  states,
                                ) {
                                  if (states.contains(MaterialState.hovered)) {
                                    return Color(0xFFED2152).withOpacity(0.1);
                                  }
                                  return Colors.transparent;
                                }),
                            side: MaterialStateProperty.resolveWith<BorderSide>(
                              (states) {
                                if (states.contains(MaterialState.hovered)) {
                                  return BorderSide(
                                    color: Color(0xFFED2152).withOpacity(0.5),
                                    width: 1,
                                  );
                                }
                                return BorderSide(
                                  color: Color(0xFFED2152).withOpacity(0.3),
                                  width: 1,
                                );
                              },
                            ),
                          ),
                      onPressed: () {
                        // Add navigation or action for second button
                      },
                      child: Text('começar', textAlign: TextAlign.center),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
