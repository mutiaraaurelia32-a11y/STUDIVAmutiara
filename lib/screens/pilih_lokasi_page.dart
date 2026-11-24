import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
import '../core/constants.dart';
import '../core/izin.dart';
import '../core/widgets.dart';

class LokasiData {
  final double lat;
  final double lng;
  final String alamat;
  const LokasiData(this.lat, this.lng, this.alamat);
}

class PilihLokasiPage extends StatefulWidget {
  const PilihLokasiPage({super.key});
  @override
  State<PilihLokasiPage> createState() => _PilihLokasiPageState();
}

class _PilihLokasiPageState extends State<PilihLokasiPage> {
  // titik awal: Bukateja, Purbalingga (dipakai kalau GPS belum aktif)
  static const _awal = LatLng(-7.4147, 109.4467);

  final _map = MapController();
  LatLng _titik = _awal;
  String _alamat = 'Mencari lokasi...';
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _lokasiSaya();
  }

  Future<void> _lokasiSaya() async {
    setState(() => _loading = true);
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        throw 'GPS belum aktif';
      }
      final ok = await Izin.minta(context, Permission.locationWhenInUse, 'Lokasi');
      if (!ok) throw 'Izin lokasi ditolak';
      final p = await Geolocator.getCurrentPosition(
          locationSettings:
              const LocationSettings(accuracy: LocationAccuracy.high));
      _titik = LatLng(p.latitude, p.longitude);
      _map.move(_titik, 17);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('$e. Pilih lokasi manual di peta.')));
      }
    }
    await _cariAlamat();
  }

  Future<void> _cariAlamat() async {
    String a;
    try {
      final list =
          await placemarkFromCoordinates(_titik.latitude, _titik.longitude);
      final p = list.first;
      a = [p.street, p.subLocality, p.locality, p.administrativeArea, p.postalCode]
          .where((e) => e != null && e.isNotEmpty)
          .join(', ');
      if (a.isEmpty) throw 'kosong';
    } catch (_) {
      a = '${_titik.latitude.toStringAsFixed(5)}, ${_titik.longitude.toStringAsFixed(5)}';
    }
    if (!mounted) return;
    setState(() {
      _alamat = a;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const AppHeader('Pilih Lokasi'),
          Expanded(
            child: Stack(
              children: [
                FlutterMap(
                  mapController: _map,
                  options: MapOptions(
                    initialCenter: _titik,
                    initialZoom: 16,
                    onTap: (_, p) {
                      setState(() {
                        _titik = p;
                        _loading = true;
                      });
                      _cariAlamat();
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.studiva',
                    ),
                    MarkerLayer(markers: [
                      Marker(
                        point: _titik,
                        width: 48,
                        height: 48,
                        alignment: Alignment.topCenter,
                        child: const Icon(Icons.location_on,
                            color: kMaroon, size: 48),
                      ),
                    ]),
                  ],
                ),
                Positioned(
                  right: 12,
                  top: 12,
                  child: FloatingActionButton.small(
                    heroTag: 'gps',
                    backgroundColor: Colors.white,
                    onPressed: _lokasiSaya,
                    child: const Icon(Icons.my_location, color: kMaroon),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: SafeArea(
              top: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Lokasi',
                      style: TextStyle(
                          color: kMaroon,
                          fontSize: 16,
                          fontWeight: FontWeight.w800)),
                  const SizedBox(height: 4),
                  Text(_alamat),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kMaroon,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24))),
                      onPressed: _loading
                          ? null
                          : () => Navigator.pop(context,
                              LokasiData(_titik.latitude, _titik.longitude, _alamat)),
                      child: const Text('Pilih Lokasi Ini'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}