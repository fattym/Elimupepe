import 'package:flutter/material.dart';
import './presentation/screens/welcome_screen.dart';

void main() => runApp(const ElimuPepeApp());

class ElimuPepeApp extends StatelessWidget {
  const ElimuPepeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elimu Pepe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: WelcomeScreen(),
    );
  }
}
