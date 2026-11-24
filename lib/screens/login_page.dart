import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../core/widgets.dart';
import 'main_shell.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _hide = true;
  final _user = TextEditingController();
  final _pass = TextEditingController();

  @override
  void dispose() {
    _user.dispose();
    _pass.dispose();
    super.dispose();
  }

  Widget _field(IconData icon, String hint, TextEditingController c,
      {bool pass = false}) {
    return Container(
      height: 56,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: kBg, borderRadius: BorderRadius.circular(30)),
      child: Row(
        children: [
          Icon(icon, color: kMaroon),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: c,
              obscureText: pass && _hide,
              style: const TextStyle(
                  color: kMaroon, fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                hintStyle: const TextStyle(
                    color: kMaroon, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          if (pass)
            GestureDetector(
              onTap: () => setState(() => _hide = !_hide),
              child: Icon(
                  _hide ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  color: kMaroon),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 80),
              const StudivaLogo(size: 36, color: kMaroon),
              const SizedBox(height: 70),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: kCard, borderRadius: BorderRadius.circular(40)),
                child: Column(
                  children: [
                    _field(Icons.person, 'Masukan NIS atau Username', _user),
                    _field(Icons.lock, 'Masukan Password', _pass, pass: true),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kMaroon,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: () => Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => const MainShell())),
                  child: const Text('Login',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}