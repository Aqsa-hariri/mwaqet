import 'dart:math';

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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _currentAthkar = '';
  final List<String> _morningAthkar = [
    "سبحان الله وبحمده",
    "الحمد لله الذي أحيانا بعدما أماتنا وإليه النشور",
    "أصبحنا وأصبح الملك لله والحمد لله لا إله إلا الله وحده لا شريك له"
  ];

  final List<String> _eveningAthkar = [
    "أمسينا وأمسى الملك لله والحمد لله لا إله إلا الله وحده لا شريك له",
    "اللهم بك أمسينا وبك أصبحنا وبك نحيا وبك نموت وإليك المصير",
    "أعوذ بكلمات الله التامات من شر ما خلق"
  ];

  final List<String> _sleepAthkar = [
    "باسمك اللهم أموت وأحيا",
    "اللهم قني عذابك يوم تبعث عبادك",
    "سبحانك اللهم ربي بك وضعت جنبي وبك أرفعه"
  ];
  String _showAthkar(List<String> athkarList) {
    setState(() {
      _currentAthkar = athkarList[Random().nextInt(athkarList.length)];
    });
    return _currentAthkar;
  }

  final String _leavingHomeDua =
      "بسم الله توكلت على الله ولا حول ولا قوة إلا بالله";
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
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('أذكار الصباح'),
              onPressed: () {
                _showAthkar(_morningAthkar);
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: Text(_currentAthkar),
                    );
                  },
                );
              },
            ),
            ElevatedButton(
              child: const Text('أذكار المساء'),
              onPressed: () {
                _showAthkar(_sleepAthkar);
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: Text(_currentAthkar),
                    );
                  },
                );
              },
            ),
            ElevatedButton(
              child: const Text('أذكار النوم'),
              onPressed: () {
                _showAthkar(_sleepAthkar);
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: Text(_currentAthkar),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
