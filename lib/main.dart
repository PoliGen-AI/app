import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:window_manager/window_manager.dart';
import 'package:tray_manager/tray_manager.dart';

import 'home_page.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize notification service first
  await NotificationService().init();

  // Inicializa o gerenciador de janelas
  await windowManager.ensureInitialized();

  // Previne fechamento direto
  await windowManager.setPreventClose(true);

  // Desabilita maximizar
  await windowManager.setMaximizable(false);
  await windowManager.setResizable(false);

  // Tray config
  await trayManager.setIcon('assets/Vector.ico'); // .ico no Windows
  await trayManager.setToolTip('PoliGen-AI');

  Menu menu = Menu(
    items: [
      MenuItem(key: 'show_window', label: 'Mostrar Janela'),
      MenuItem.separator(),
      MenuItem(key: 'settings', label: 'Configurações'),
      MenuItem.separator(),
      MenuItem(key: 'exit_app', label: 'Sair'),
    ],
  );
  await trayManager.setContextMenu(menu);
  trayManager.addListener(_TrayListener());

  // Opções da janela
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
    await windowManager.show();
    await windowManager.focus();
    // Do not auto-maximize - keep window at preferred size
    await windowManager.setMinimizable(true);
    await windowManager.setClosable(true);
  });

  // Listener da janela
  windowManager.addListener(_WindowListener());

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

class _TrayListener with TrayListener {
  @override
  void onTrayIconMouseDown() {
    windowManager.show();
    windowManager.focus();
  }

  @override
  void onTrayIconRightMouseDown() {
    trayManager.popUpContextMenu();
  }

  @override
  void onTrayMenuItemClick(MenuItem menuItem) async {
    switch (menuItem.key) {
      case 'show_window':
        await windowManager.show();
        await windowManager.focus();
        break;
      case 'settings':
        await windowManager.show();
        await windowManager.focus();
        // TODO: Navegar para a tela de configurações
        break;
      case 'exit_app':
        await windowManager.destroy(); // Fecha de verdade
        break;
    }
  }
}

class _WindowListener with WindowListener {
  @override
  void onWindowClose() async {
    // Check if we have prevent close enabled
    final bool isPreventClose = await windowManager.isPreventClose();
    if (isPreventClose) {
      // Hide to tray and show notification
      await windowManager.hide();
      await NotificationService().showTrayNotification();
      return;
    }
    // Otherwise, allow normal destroy
    await windowManager.destroy();
  }

  @override
  void onWindowMinimize() {
    // Comportamento padrão
  }

  @override
  void onWindowRestore() {
    // Opcional
  }
}
