import 'dart:async';
import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../core/widgets.dart';
import 'login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer? _t;

  @override
  void initState() {
    super.initState();
    _t = Timer(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const LoginPage()));
    });
  }

  @override
  void dispose() {
    _t?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMaroon,
      body: SafeArea(
        child: Column(
          children: const [
            Spacer(flex: 3),
            StudivaLogo(size: 48),
            Spacer(flex: 4),
            Text('Aplikasi digital untuk seluruh\naktivitas siswa',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600)),
            SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}