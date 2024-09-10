import 'package:flutter/material.dart';
import 'package:mwaquite/electronic_tasbeeh.dart';
import 'package:mwaquite/prayer_times.dart';
import 'package:mwaquite/quiblah_page.dart';
import 'package:mwaquite/quran_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'islamic app',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الصفحة الرئيسية'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text('مواقيت الصلاة'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const PrayerTimesPage()), // تم تغيير هذا السطر
                );
              },
            ),
            ElevatedButton(
              child: const Text('السبحة الإلكترونية'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ElectronicTasbeeh()),
                );
              },
            ),
            ElevatedButton(
              child: const Text('القرآن الكريم'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuranPage()),
                );
              },
            ),
            ElevatedButton(
              child: const Text(' القبله'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const QuiblahScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
