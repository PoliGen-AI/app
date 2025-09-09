import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:window_manager/window_manager.dart';
import 'package:tray_manager/tray_manager.dart';

// 1. Importe o serviço de notificação que criamos
import 'services/notification_service.dart';
import 'home_page.dart'; // Supondo que sua MyHomePage esteja aqui

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Inicialize o serviço de notificação logo no início
  await NotificationService().init();

  await windowManager.ensureInitialized();

  // O listener da janela agora chamará nosso serviço de notificação
  windowManager.addListener(_WindowListener());

  // Garante que o setPreventClose(true) seja chamado para interceptar o fechamento
  await windowManager.setPreventClose(true);

  await trayManager.setIcon(
    'assets/Vector.ico',
  ); // Certifique-se que este arquivo existe em assets
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
    await Future.delayed(const Duration(milliseconds: 100));
    await windowManager.maximize();
    await windowManager.focus();
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
        // TODO: Navigate to settings page
        break;
      case 'exit_app':
        // IMPORTANTE: Usamos destroy() para fechar o app de verdade.
        // Se usássemos close(), ele apenas esconderia a janela de novo.
        await windowManager.destroy();
        break;
    }
  }
}

class _WindowListener with WindowListener {
  @override
  void onWindowClose() async {
    // Esconde a janela para a bandeja
    await windowManager.hide();

    // 3. Chama o nosso serviço para mostrar a notificação do sistema
    await NotificationService().showTrayNotification();
    // O código antigo de debugPrint e a função _showSystemNotification foram removidos.
  }

  // Outros listeners podem ser mantidos se você precisar deles
  @override
  void onWindowMinimize() {
    // Comportamento normal de minimizar
  }

  @override
  void onWindowRestore() {
    // Opcional: lidar com evento de restauração
  }
}
