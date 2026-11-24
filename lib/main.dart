import 'package:flutter/material.dart';
import 'core/constants.dart';
import 'screens/splash_page.dart';

void main() => runApp(const StudivaApp());

class StudivaApp extends StatelessWidget {
  const StudivaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Studiva',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kMaroon,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: kMaroon),
        useMaterial3: true,
      ),
      home: const SplashPage(),
    );
  }
}