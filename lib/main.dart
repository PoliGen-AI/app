import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:window_manager/window_manager.dart';
import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();

  WindowOptions windowOptions = WindowOptions(
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
    title: 'PoliGen-AI',
    minimumSize: const Size(700, 500),
    maximumSize: const Size(1000, 650),
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    // Show the window first
    await windowManager.show();

    // Small delay to ensure window is ready
    await Future.delayed(const Duration(milliseconds: 100));

    // Start maximized to automatically fit any screen size
    await windowManager.maximize();
    await windowManager.focus();

    // Allow window controls
    await windowManager.setMaximizable(true);
    await windowManager.setMinimizable(true);
    await windowManager.setClosable(true);
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aurora Background Demo',
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        textTheme: GoogleFonts.interTextTheme(
          ThemeData.dark(useMaterial3: true).textTheme,
        ),
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}
