// services/notification_service.dart

import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  // Instância estática e final para garantir que o plugin seja único em todo o app.
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  // Instância singleton do nosso próprio serviço.
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  // Flag para sabermos se a inicialização já ocorreu.
  bool _initialized = false;

  Future<void> init() async {
    // Evita reinicializações desnecessárias.
    if (_initialized) {
      return;
    }

    try {
      // Configurações básicas para todas as plataformas
      const DarwinInitializationSettings initializationSettingsDarwin =
          DarwinInitializationSettings();

      const LinuxInitializationSettings initializationSettingsLinux =
          LinuxInitializationSettings(defaultActionName: 'Abrir');

      final InitializationSettings initializationSettings =
          InitializationSettings(
            macOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux,
          );

      // Inicializa o plugin com as configurações definidas.
      // O 'await' garante que o código só continue após a conclusão.
      final bool? result = await _plugin.initialize(initializationSettings);

      if (result == true) {
        // Marca como inicializado.
        _initialized = true;
        print(
          '✅ NotificationService inicializado com sucesso na plataforma ${Platform.operatingSystem}!',
        );
      } else {
        print(
          '❌ Falha ao inicializar NotificationService na plataforma ${Platform.operatingSystem}',
        );
        _initialized = false;
      }
    } catch (e) {
      print('❌ Erro ao inicializar NotificationService: $e');
      _initialized = false;
      // Não propaga o erro para não quebrar o app
    }
  }

  Future<void> showTrayNotification() async {
    // Checagem de segurança. Se não foi inicializado, não faz nada.
    if (!_initialized) {
      print('❌ Erro: showTrayNotification chamado antes da inicialização.');
      return;
    }

    try {
      const NotificationDetails platformChannelSpecifics =
          NotificationDetails();

      await _plugin.show(
        0,
        'Aplicativo em Execução',
        'O aplicativo foi minimizado para a bandeja do sistema.',
        platformChannelSpecifics,
      );

      print(
        '✅ Notificação exibida com sucesso na plataforma ${Platform.operatingSystem}',
      );
    } catch (e) {
      print(
        '❌ Erro ao mostrar notificação na plataforma ${Platform.operatingSystem}: $e',
      );

      // Para Windows, informar ao usuário sobre limitações
      if (Platform.isWindows) {
        print(
          'ℹ️  Windows notifications dependem do sistema de notificações nativo.',
        );
        print(
          'ℹ️  Certifique-se de que as notificações estão habilitadas nas configurações do Windows.',
        );
      }

      // Não propaga o erro para não quebrar o fluxo de fechamento da janela
    }
  }
}
