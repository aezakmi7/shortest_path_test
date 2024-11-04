import 'package:flutter/material.dart';

import 'repo/app_config_repository.dart';
import 'repo/app_settings.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final configRepo = AppConfigRepository();
    final appSettings = AppSettings()..init();

    return MaterialApp(
      title: 'Flutter Test Task',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(0, 189, 67, 67),
        ),
        useMaterial3: true,
      ),
      home: HomeScreen(
        configRepo: configRepo,
        appSettings: appSettings,
      ),
    );
  }
}
