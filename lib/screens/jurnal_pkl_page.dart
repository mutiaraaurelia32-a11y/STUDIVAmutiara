import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../core/widgets.dart';

class JurnalPklPage extends StatefulWidget {
  const JurnalPklPage({super.key});
  @override
  State<JurnalPklPage> createState() => _JurnalPklPageState();
}

class _JurnalPklPageState extends State<JurnalPklPage> {
  final List<Map<String, String>> _entries = [];

  String _fmt(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

  void _tambah() {
    final judul = TextEditingController();
    final isi = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.fromLTRB(
            20, 20, 20, MediaQuery.of(ctx).viewInsets.bottom + 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Tambah Jurnal',
                style: TextStyle(
                    color: kMaroon, fontSize: 20, fontWeight: FontWeight.w800)),
            const SizedBox(height: 14),
            TextField(
              controller: judul,
              decoration: const InputDecoration(
                  labelText: 'Judul kegiatan', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: isi,
              maxLines: 4,
              decoration: const InputDecoration(
                  labelText: 'Deskripsi kegiatan',
                  border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: kMaroon, foregroundColor: Colors.white),
                onPressed: () {
                  if (judul.text.trim().isEmpty) return;
                  setState(() => _entries.insert(0, {
                        'tanggal': _fmt(DateTime.now()),
                        'judul': judul.text.trim(),
                        'isi': isi.text.trim(),
                      }));
                  Navigator.pop(ctx);
                },
                child: const Text('Simpan'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _detail(Map<String, String> e) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(e['judul']!,
            style: const TextStyle(color: kMaroon, fontWeight: FontWeight.w800)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(e['tanggal']!, style: const TextStyle(color: Colors.black54)),
            const SizedBox(height: 10),
            Text(e['isi']!.isEmpty ? '-' : e['isi']!),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() => _entries.remove(e));
              Navigator.pop(context);
            },
            child: const Text('Hapus'),
          ),
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tutup')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      floatingActionButton: FloatingActionButton(
        backgroundColor: kMaroon,
        onPressed: _tambah,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Column(
        children: [
          const AppHeader('Jurnal PKL'),
          Expanded(
            child: _entries.isEmpty
                ? const Center(
                    child: Text('Belum ada jurnal.\nTekan + untuk menambah.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: kMaroon)))
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
                    itemCount: _entries.length,
                    itemBuilder: (_, i) {
                      final e = _entries[i];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: ListTile(
                          onTap: () => _detail(e),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 6),
                          leading: const CircleAvatar(
                              backgroundColor: kMaroon,
                              child: Icon(Icons.edit_note, color: kPink)),
                          title: Text(e['judul']!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700)),
                          subtitle: Text(e['tanggal']!),
                          trailing:
                              const Icon(Icons.chevron_right, color: kMaroon),
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