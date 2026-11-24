import 'package:flutter/material.dart';
import '../core/widgets.dart';

class CbtPage extends StatelessWidget {
  const CbtPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppHeader('CBT', showBack: false),
        Expanded(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/cbt.png',
                  width: 280,
                  errorBuilder: (_, __, ___) => const Icon(
                      Icons.build_circle_outlined,
                      size: 200,
                      color: Color(0xFF8FD3A8)),
                ),
                const SizedBox(height: 24),
                const Text('CBT Segera Hadir!',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
                const SizedBox(height: 6),
                const Text('Fitur CBT sedang kami siapkan. Tunggu yaa!',
                    style: TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}