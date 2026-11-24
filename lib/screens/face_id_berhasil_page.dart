import 'package:flutter/material.dart';
import '../core/constants.dart';

class FaceIdBerhasilPage extends StatelessWidget {
  const FaceIdBerhasilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const Spacer(flex: 3),
              const Icon(Icons.verified, color: kGreen, size: 150),
              const SizedBox(height: 16),
              const Text('Face ID Berhasil',
                  style: TextStyle(
                      color: kMaroon,
                      fontSize: 26,
                      fontWeight: FontWeight.w800)),
              const SizedBox(height: 16),
              const Text(
                  'Verifikasi wajah kamu sudah berhasil,\nkamu sekarang bisa melanjutkan',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: kMaroon)),
              const Spacer(flex: 4),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kGreen,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: () =>
                      Navigator.popUntil(context, (r) => r.isFirst),
                  child: const Text('Lanjut',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}