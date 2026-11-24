import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../core/widgets.dart';

class JadwalPage extends StatefulWidget {
  const JadwalPage({super.key});
  @override
  State<JadwalPage> createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
  static const _hari = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat'];

  // [jam, mata pelajaran, guru]
  static const Map<String, List<List<String>>> _data = {
    'Senin': [
      ['07.00 - 08.30', 'Matematika', 'Dyah Ratna Purnandari, S.Pd.'],
      ['08.30 - 10.00', 'Bahasa Indonesia', 'Nur Yuliandrianingtyas, S.Pd.'],
      ['10.15 - 11.45', 'Bahasa Inggris', 'Yunita Kusuma Wardhani, S.Pd.'],
    ],
    'Selasa': [
      ['07.00 - 08.30', 'Jurusan (RPL)', 'Paras Taufani, S.Kom.'],
      ['08.30 - 10.00', 'Jurusan (RPL)', 'Paras Taufani, S.Kom.'],
      ['10.15 - 11.45', 'Bahasa Jawa', 'Dyan Kartikawati, S.Pd.'],
    ],
    'Rabu': [
      ['07.00 - 08.30', 'PJOK', 'Syaiful Dwi Jatmiko, S.Pd.'],
      ['08.30 - 10.00', 'Matematika', 'Dyah Ratna Purnandari, S.Pd.'],
      ['10.15 - 11.45', 'Bahasa Jepang', 'Imam Maulana Burhannudien, S.Pd.'],
    ],
    'Kamis': [
      ['07.00 - 08.30', 'Pendidikan Agama Islam', 'Eko Saputra'],
      ['08.30 - 10.00', 'Bimbingan Konseling', 'Abdi Sholih Pratama, S.Pd.'],
      ['10.15 - 11.45', 'Bahasa Inggris', 'Yunita Kusuma Wardhani, S.Pd.'],
    ],
    'Jumat': [
      ['07.00 - 08.30', 'Kreativitas, Inovasi, dan Kewirausahaan', 'Abdi Sholih Pratama, S.Pd.'],
      ['08.30 - 10.00', 'Bahasa Indonesia', 'Nur Yuliandrianingtyas, S.Pd.'],
    ],
  };

  late String _selected;

  @override
  void initState() {
    super.initState();
    final w = DateTime.now().weekday; // 1 = Senin
    _selected = (w >= 1 && w <= 5) ? _hari[w - 1] : _hari.first;
  }

  @override
  Widget build(BuildContext context) {
    final items = _data[_selected] ?? [];
    return Scaffold(
      backgroundColor: kBg,
      body: Column(
        children: [
          const AppHeader('Jadwal Pelajaran'),
          SizedBox(
            height: 64,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(12),
              itemCount: _hari.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) {
                final h = _hari[i];
                final sel = h == _selected;
                return GestureDetector(
                  onTap: () => setState(() => _selected = h),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: sel ? kMaroon : Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Text(h,
                        style: TextStyle(
                            color: sel ? Colors.white : kMaroon,
                            fontWeight: FontWeight.w700)),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: items.isEmpty
                ? const Center(
                    child: Text('Tidak ada jadwal',
                        style: TextStyle(color: kMaroon)))
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                    itemCount: items.length,
                    itemBuilder: (_, i) {
                      final it = items[i];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            Container(
                              width: 6,
                              height: 56,
                              decoration: BoxDecoration(
                                  color: kMaroon,
                                  borderRadius: BorderRadius.circular(3)),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(it[1],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 16)),
                                  const SizedBox(height: 4),
                                  Text(it[2],
                                      style: const TextStyle(
                                          color: Colors.black54)),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(Icons.access_time,
                                          size: 16, color: kMaroon),
                                      const SizedBox(width: 4),
                                      Text(it[0],
                                          style: const TextStyle(
                                              color: kMaroon,
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}