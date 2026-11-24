import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../core/widgets.dart';
import 'jadwal_page.dart';
import 'jurnal_pkl_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  String get _today {
    final n = DateTime.now();
    return '${n.day.toString().padLeft(2, '0')}/${n.month.toString().padLeft(2, '0')}';
  }

  Widget _info(IconData icon, String top, String bottom) {
    return Row(
      children: [
        Icon(icon, color: kMaroon, size: 30),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(top, style: const TextStyle(color: kMaroon, fontSize: 15)),
            Text(bottom,
                style: const TextStyle(color: kMaroon, fontSize: 14)),
          ],
        ),
      ],
    );
  }

  Widget _presRow(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          ClipOval(
            child: Container(
              width: 46,
              height: 46,
              color: const Color(0xFFE6E0E2),
              child: const Icon(Icons.person, color: Colors.white, size: 34),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      color: kMaroon, fontWeight: FontWeight.w700)),
              const Text('--:-- | --:--',
                  style: TextStyle(color: kMaroon, fontSize: 13)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _menu(IconData icon, String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: onTap,
          child: Container(
            height: 96,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: kMaroon,
                  child: Icon(icon, color: kPink, size: 28),
                ),
                const SizedBox(height: 6),
                Text(title,
                    style: const TextStyle(
                        color: kMaroon, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBg,
      child: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          children: [
            Row(
              children: [
                const Avatar(70),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('HII!', style: TextStyle(color: kMaroon)),
                      Text(kNama,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                  color: const Color(0x99FFFFFF),
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _info(Icons.calendar_month, _today, 'Tanggal'),
                  _info(Icons.access_time_filled, '--:--', 'Masuk'),
                  _info(Icons.access_time_filled, '--:--', 'Pulang'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                  color: kCard, borderRadius: BorderRadius.circular(24)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Presensi',
                      style: TextStyle(
                          color: kMaroon,
                          fontWeight: FontWeight.w800,
                          fontSize: 16)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        _presRow('Presensi Masuk'),
                        _presRow('Presensi Pulang'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _menu(Icons.event_note, 'Jadwal Pelajaran', () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const JadwalPage()));
            }),
            _menu(Icons.description, 'Ajukan Perizinan', () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Fitur Perizinan segera hadir')));
            }),
            _menu(Icons.calendar_month, 'Jurnal PKL', () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const JurnalPklPage()));
            }),
          ],
        ),
      ),
    );
  }
}