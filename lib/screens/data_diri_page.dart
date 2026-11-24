import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../core/widgets.dart';

class DataDiriPage extends StatelessWidget {
  const DataDiriPage({super.key});

  Widget _row(String k, String v) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 4,
                child: Text(k, style: const TextStyle(color: kMaroon))),
            Expanded(
                flex: 5,
                child: Text(v,
                    textAlign: TextAlign.right,
                    style: const TextStyle(color: kMaroon))),
          ],
        ),
      );

  Widget _title(String t) => Padding(
        padding: const EdgeInsets.only(top: 6, bottom: 4),
        child: Text(t,
            style: const TextStyle(
                color: kMaroon, fontWeight: FontWeight.w800, fontSize: 16)),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: Column(
        children: [
          const AppHeader('Data Diri'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _title('Data Personal'),
                _row('Nama', 'Mutiara Aurelia Zabrina'),
                _row('Tempat Lahir', 'Purbalingga'),
                _row('Tanggal Lahir', '5 Desember 2010'),
                _row('Jenis Kelamin', 'Perempuan'),
                _row('Telepon', '-'),
                _row('NIS', '9238'),
                _row('NISN', '0101931462'),
                _row('NIK', '-'),
                _row('Agama', 'Islam'),
                _row('Alamat', 'Majasari Majasari Kec. Bukateja Kab. Purbalingga'),
                _row('Anak Ke-', '-'),
                _row('Status Anak', '-'),
                _row('Asal Sekolah', '-'),
                _row('Nomor Surat Tanda Lulus', '-'),
                _row('Tanggal Surat Tanda Lulus', '-'),
                _title('Data Orang Tua'),
                _row('Nama Ayah', '-'),
                _row('Pekerjaan Ayah', '-'),
                _row('Nama Ibu', '-'),
                _row('Pekerjaan Ibu', '-'),
                _row('Alamat Orangtua', '-'),
                _row('Telepon Orangtua', '-'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}