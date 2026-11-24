import 'package:flutter/material.dart';
import '../core/constants.dart';

class LmsPage extends StatefulWidget {
  const LmsPage({super.key});
  @override
  State<LmsPage> createState() => _LmsPageState();
}

class _LmsPageState extends State<LmsPage> {
  static const _all = [
    ['BIND', 'BAHASA INDONESIA', 'NUR YULIANDRIANINGTYAS, S.Pd.', 0xFF2E9B57],
    ['BING', 'BAHASA INGGRIS', 'YUNITA KUSUMA WARDHANI, S.Pd.', 0xFF1E7BC6],
    ['BJ', 'BAHASA JAWA', 'DYAN KARTIKAWATI, S.Pd.', 0xFF4C58B0],
    ['BK', 'BIMBINGAN KONSELING', 'ABDI SHOLIH PRATAMA, S.Pd.', 0xFF1A8CA6],
    ['B. Jepang', 'BAHASA JEPANG', 'IMAM MAULANA BURHANNUDIEN, S.Pd.', 0xFF6B4B42],
    ['KIK', 'KREATIVITAS, INOVASI, DAN KEWIRAUSAHAAN', 'ABDI SHOLIH PRATAMA, S.Pd.', 0xFF3FA9B8],
    ['MTK', 'MATEMATIKA', 'DYAH RATNA PURNANDARI, S.Pd.', 0xFF8570C9],
    ['PAIBP', 'PENDIDIKAN AGAMA ISLAM', 'EKO SAPUTRA', 0xFFC27BA0],
  ];

  String _q = '';

  Widget _stat(String n, String label) => Column(
        children: [
          Text(n, style: const TextStyle(fontWeight: FontWeight.w600)),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      );

  @override
  Widget build(BuildContext context) {
    final list = _all
        .where((s) =>
            (s[1] as String).toLowerCase().contains(_q.toLowerCase()))
        .toList();
    return Container(
      color: kBg,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Row(
                children: const [
                  CircleAvatar(
                      radius: 32,
                      backgroundColor: kMaroon,
                      child: Icon(Icons.school_rounded,
                          color: Colors.white, size: 34)),
                  SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Pembelajaran',
                            style: TextStyle(
                                color: kMaroon,
                                fontSize: 24,
                                fontWeight: FontWeight.w800)),
                        Text('SMK N 1 Bukateja - XI RPL1',
                            style: TextStyle(
                                color: kMaroon, fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _stat('14', 'Mata Pelajaran'),
                  _stat('0', 'Materi'),
                  _stat('0', 'Tugas'),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 14, 20, 10),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: TextField(
                onChanged: (v) => setState(() => _q = v),
                style: const TextStyle(color: kMaroon),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: kPink),
                  hintText: 'Cari mata pelajaran....',
                  hintStyle: TextStyle(color: kMaroon),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                itemCount: list.length,
                itemBuilder: (_, i) {
                  final s = list[i];
                  return Container(
                    height: 78,
                    margin: const EdgeInsets.only(bottom: 8),
                    color: kCard,
                    child: Row(
                      children: [
                        Container(
                          width: 84,
                          color: Color(s[3] as int),
                          alignment: Alignment.center,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 12),
                            decoration: BoxDecoration(
                                color: const Color(0x55FFFFFF),
                                borderRadius: BorderRadius.circular(14)),
                            child: Text(s[0] as String,
                                style: TextStyle(
                                    color: Color(s[3] as int),
                                    fontWeight: FontWeight.w800)),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(s[1] as String,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w800)),
                              Text(s[2] as String,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 12)),
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
      ),
    );
  }
}