import 'package:flutter/material.dart';
import 'constants.dart';

class StudivaLogo extends StatelessWidget {
  final double size;
  final Color color;
  const StudivaLogo({super.key, this.size = 44, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/logo.png',
          width: size * 3,
          errorBuilder: (_, __, ___) =>
              Icon(Icons.school_rounded, size: size * 2.2, color: color),
        ),
        Text('Studiva',
            style: TextStyle(
                fontSize: size,
                fontWeight: FontWeight.w800,
                letterSpacing: 4,
                color: color)),
        const SizedBox(height: 4),
        Text('Belajar • Hadir • Berprestasi',
            style: TextStyle(color: color, fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class Avatar extends StatelessWidget {
  final double size;
  const Avatar(this.size, {super.key});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.asset(
        'assets/images/avatar.png',
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          width: size,
          height: size,
          color: kMaroon,
          child: Icon(Icons.person, color: Colors.white, size: size * .6),
        ),
      ),
    );
  }
}

class AppHeader extends StatelessWidget {
  final String title;
  final bool showBack;
  const AppHeader(this.title, {super.key, this.showBack = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: kMaroon,
      padding: EdgeInsets.fromLTRB(
          8, MediaQuery.of(context).padding.top + 8, 8, 16),
      child: Row(
        children: [
          showBack
              ? IconButton(
                  icon: const Icon(Icons.arrow_back, color: kPink, size: 28),
                  onPressed: () => Navigator.pop(context),
                )
              : const SizedBox(width: 48),
          Expanded(
            child: Center(
              child: Text(title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700)),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }
}