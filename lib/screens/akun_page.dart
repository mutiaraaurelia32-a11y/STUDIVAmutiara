import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../core/widgets.dart';
import 'login_page.dart';
import 'data_diri_page.dart';
import 'presensi_wajah_page.dart';

class AkunPage extends StatelessWidget {
  const AkunPage({super.key});

  Widget _stat(String n, String label) => Column(
        children: [
          Text(n, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w800)),
        ],
      );

  Widget _item(IconData icon, String label, VoidCallback onTap) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: kMaroon, size: 30),
      title: Text(label,
          style: const TextStyle(color: kMaroon, fontWeight: FontWeight.w700)),
      trailing: const Text('>',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBg,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            color: kMaroon,
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 24, bottom: 20),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: const Avatar(120),
                ),
                const SizedBox(height: 14),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(14),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: kCard, borderRadius: BorderRadius.circular(20)),
                  child: const Column(
                    children: [
                      Text('MUTIARA AURELIA ZABRINA',
                          style: TextStyle(
                              color: kMaroon,
                              fontSize: 19,
                              fontWeight: FontWeight.w800)),
                      Text('$kNis | $kKelas | $kSekolah',
                          style: TextStyle(
                              color: kMaroon, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
                color: kCard, borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _stat('0', 'Hadir'),
                _stat('0', 'Sakit'),
                _stat('0', 'Izin'),
                _stat('0', 'Alpha'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 4),
              decoration: BoxDecoration(
                  color: kMaroon, borderRadius: BorderRadius.circular(20)),
              child: const Text('Profil',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700)),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            decoration: BoxDecoration(
                color: kCard, borderRadius: BorderRadius.circular(24)),
            child: Column(
              children: [
                _item(Icons.person, 'Data Diri', () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const DataDiriPage()));
                }),
                _item(Icons.face_retouching_natural, 'Registrasi Wajah', () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const PresensiWajahPage()));
                }),
                _item(Icons.refresh, 'Reset Wajah', () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Data wajah direset')));
                }),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            child: SizedBox(
              height: 52,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kMaroon,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                icon: const Icon(Icons.logout),
                label: const Text('Logout',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                onPressed: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                    (r) => false),
              ),
            ),
          ),
        ],
      ),
    );
  }
}