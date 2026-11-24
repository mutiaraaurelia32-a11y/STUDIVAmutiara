import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class Izin {
  /// Minta izin. Return true kalau diizinkan.
  /// Kalau ditolak permanen, tampilkan dialog menuju Pengaturan.
  static Future<bool> minta(
      BuildContext context, Permission izin, String nama) async {
    final status = await izin.request();
    if (status.isGranted || status.isLimited) return true;

    if (!context.mounted) return false;
    if (status.isPermanentlyDenied || status.isRestricted) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Izin $nama dibutuhkan'),
          content: Text(
              'Izin $nama ditolak. Aktifkan lewat Pengaturan aplikasi agar fitur ini bisa dipakai.'),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Batal')),
            TextButton(
              onPressed: () {
                openAppSettings();
                Navigator.pop(ctx);
              },
              child: const Text('Buka Pengaturan'),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Izin $nama ditolak')));
    }
    return false;
  }
}