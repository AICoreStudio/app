import 'package:flutter/material.dart';
import 'package:starweaver/theme.dart';
import 'package:starweaver/screens/date_selection_screen.dart';

void main() {
  runApp(const StarWeaverApp());
}

class StarWeaverApp extends StatelessWidget {
  const StarWeaverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StarWeaver - Космический Гороскоп',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      home: const DateSelectionScreen(),
    );
  }
}
