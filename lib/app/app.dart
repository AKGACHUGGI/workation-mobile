import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../features/home/home_screen.dart';

class WorkationApp extends StatelessWidget {
  const WorkationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '워케이션(가제)',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const HomeScreen(), // M-01
    );
  }
}
