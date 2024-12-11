import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'home_page.dart'; // Assure-toi que le chemin est correct


void main() async {
  // flutter run --dart-define=apiKey='AIzaSyBwpZJe_hRp_R3yXZtSnWRp7JDXUvs9uS4'
  Gemini.init(
    apiKey: const String.fromEnvironment('apiKey'),
    enableDebugging: true,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Gemini',
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        cardTheme: CardTheme(color: Colors.blue.shade900),
      ),
      home: const HomePage(), // Changez ici
    );
  }
}
