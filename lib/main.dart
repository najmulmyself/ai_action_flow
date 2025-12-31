import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'features/text_editor/screens/text_editor_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Action Flow',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const TextEditorScreen(),
    );
  }
}
