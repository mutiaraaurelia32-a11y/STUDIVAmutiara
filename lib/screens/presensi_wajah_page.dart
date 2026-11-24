import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../core/constants.dart';
import '../core/izin.dart';
import '../core/widgets.dart';
import 'face_id_berhasil_page.dart';
import 'pilih_lokasi_page.dart';

class PresensiWajahPage extends StatefulWidget {
  const PresensiWajahPage({super.key});
  @override
  State<PresensiWajahPage> createState() => _PresensiWajahPageState();
}

class _PresensiWajahPageState extends State<PresensiWajahPage> {
  final _picker = ImagePicker();
  File? _foto;

  Future<void> _ambilFoto() async {
    if (!await Izin.minta(context, Permission.camera, 'Kamera')) return;
    try {
      final x = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 80,
        maxWidth: 1080,
      );
      if (x == null || !mounted) return;
      setState(() => _foto = File(x.path));

      // langkah 2: pilih lokasi di peta
      final lokasi = await Navigator.push<LokasiData>(
          context, MaterialPageRoute(builder: (_) => const PilihLokasiPage()));
      if (lokasi == null || !mounted) return;

      // langkah 3: konfirmasi
      final ya = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          title: const Text('Wajah Terdeteksi',
              style: TextStyle(fontWeight: FontWeight.w800)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: kCard, borderRadius: BorderRadius.circular(12)),
                child:  Center(child: Text(kNama.toUpperCase())),
              ),
              const SizedBox(height: 12),
              const Text('Lokasi',
                  style: TextStyle(fontWeight: FontWeight.w800)),
              Text(lokasi.alamat),
              const SizedBox(height: 12),
              const Center(
                  child: Text('Apakah anda yakin melakukan presensi?',
                      style: TextStyle(fontWeight: FontWeight.w700))),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Tidak')),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: kMaroon, foregroundColor: Colors.white),
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Ya'),
            ),
          ],
        ),
      );
      if (ya != true || !mounted) return;
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => const FaceIdBerhasilPage()));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Kamera tidak dapat dibuka. Cek izin kamera.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const AppHeader('Presensi Wajah'),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 280,
                  height: 340,
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 70),
                  decoration: BoxDecoration(
                      color: const Color(0xFFF8BBC8),
                      borderRadius: BorderRadius.circular(8)),
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(4),
                    width: double.infinity,
                    child: _foto != null
                        ? Image.file(_foto!, fit: BoxFit.cover)
                        : Container(
                            color: kBg,
                            child: const Icon(Icons.person,
                                size: 120, color: kPink),
                          ),
                  ),
                ),
                const SizedBox(height: 14),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                      'Pastikan wajah terlihat jelas dan tidak menggunakan masker/topeng',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: kMaroon)),
                ),
                const SizedBox(height: 40),
                GestureDetector(
                  onTap: _ambilFoto,
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: const BoxDecoration(
                        color: kMaroon, shape: BoxShape.circle),
                    child: const Icon(Icons.photo_camera,
                        color: Colors.white, size: 44),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}