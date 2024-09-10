import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SurahPage extends StatefulWidget {
  final int surahNumber;
  final String surahName;

  SurahPage({required this.surahNumber, required this.surahName});

  @override
  _SurahPageState createState() => _SurahPageState();
}

class _SurahPageState extends State<SurahPage> {
  List<dynamic> ayahs = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAyahs();
  }

  Future<void> fetchAyahs() async {
    final response = await http.get(Uri.parse('http://api.alquran.cloud/v1/surah/${widget.surahNumber}'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        ayahs = data['data']['ayahs'];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      // يمكنك إضافة معالجة الأخطاء هنا
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.surahName),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: ayahs.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(ayahs[index]['text'],
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 18),
            ),
            leading: CircleAvatar(
              child: Text(ayahs[index]['numberInSurah'].toString()),
            ),
          );
        },
      ),
    );
  }
}