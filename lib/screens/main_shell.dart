import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../core/constants.dart';
import 'home_page.dart';
import 'lms_page.dart';
import 'cbt_page.dart';
import 'akun_page.dart';
import 'presensi_wajah_page.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  @override
  void initState() {
    super.initState();
    // minta izin kamera & lokasi saat pertama masuk
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await [Permission.camera, Permission.locationWhenInUse].request();
    });
  }

  Widget _item(int i, IconData icon, String label) {
    final sel = _index == i;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _index = i),
        child: Container(
          color: sel ? Colors.white : Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: kMaroon, size: 30),
              Text(label,
                  style: TextStyle(
                      color: kMaroon,
                      fontSize: 12,
                      fontWeight: sel ? FontWeight.w800 : FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _index,
        children: const [
          HomePage(),
          LmsPage(),
          SizedBox.shrink(),
          CbtPage(),
          AkunPage(),
        ],
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: SizedBox(
          height: 96,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                height: 68,
                child: Container(
                  color: kBg,
                  child: Row(
                    children: [
                      _item(0, Icons.home_rounded, 'Home'),
                      _item(1, Icons.school_rounded, 'LMS'),
                      const Expanded(child: SizedBox()),
                      _item(3, Icons.assignment_rounded, 'CBT'),
                      _item(4, Icons.person_rounded, 'Akun'),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const PresensiWajahPage())),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: kMaroon,
                            shape: BoxShape.circle,
                            border: Border.all(color: kBg, width: 3),
                          ),
                          child: const Icon(Icons.face_retouching_natural,
                              color: Colors.white, size: 34),
                        ),
                        const SizedBox(height: 2),
                        const Text('Presensi',
                            style: TextStyle(
                                color: kMaroon,
                                fontSize: 12,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}