import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class PrayerTimesPage extends StatefulWidget {
  const PrayerTimesPage({super.key});

  @override
  _PrayerTimesPageState createState() => _PrayerTimesPageState();
}

class _PrayerTimesPageState extends State<PrayerTimesPage> {
  PrayerTimes? _prayerTimes;
  String _location = 'جاري تحديد الموقع...';

  @override
  void initState() {
    super.initState();
    _checkPermissionsAndGetPrayerTimes();
  }

  Future<void> _checkPermissionsAndGetPrayerTimes() async {
    final status = await Permission.location.status;

    if (status.isGranted) {
      _getPrayerTimes();
    } else if (status.isDenied) {
      // Request permission
      final result = await Permission.location.request();
      if (result.isGranted) {
        _getPrayerTimes();
      } else {
        setState(() {
          _location = 'الرجاء منح إذن الوصول إلى الموقع';
        });
      }
    } else {
      setState(() {
        _location = 'الرجاء منح إذن الوصول إلى الموقع';
      });
    }
  }

  Future<void> _getPrayerTimes() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      final coordinates = Coordinates(position.latitude, position.longitude);
      final params = CalculationMethod.egyptian.getParameters();
      params.madhab = Madhab.shafi;

      final date = DateComponents.from(DateTime.now());
      final prayerTimes = PrayerTimes(coordinates, date, params);

      setState(() {
        _prayerTimes = prayerTimes;
        _location =
            '${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)}';
      });
    } catch (e) {
      print('Error getting prayer times: $e');
      setState(() {
        _location = 'حدث خطأ في تحديد الموقع';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مواقيت الصلاة'),
      ),
      body: Center(
        child: _prayerTimes == null
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('الموقع: $_location'),
                  const SizedBox(height: 20),
                  _buildPrayerTimeRow('الفجر', _prayerTimes!.fajr),
                  _buildPrayerTimeRow('الشروق', _prayerTimes!.sunrise),
                  _buildPrayerTimeRow('الظهر', _prayerTimes!.dhuhr),
                  _buildPrayerTimeRow('العصر', _prayerTimes!.asr),
                  _buildPrayerTimeRow('المغرب', _prayerTimes!.maghrib),
                  _buildPrayerTimeRow('العشاء', _prayerTimes!.isha),
                ],
              ),
      ),
    );
  }

  Widget _buildPrayerTimeRow(String prayerName, DateTime? time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(prayerName, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 10),
          Text(_formatTime(time)),
        ],
      ),
    );
  }

  String _formatTime(DateTime? time) {
    return time != null ? DateFormat.jm().format(time.toLocal()) : 'N/A';
  }
}
