import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'surah_page.dart';

class QuranPage extends StatefulWidget {
  @override
  _QuranPageState createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  List<dynamic> surahs = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSurahs();
  }

  Future<void> fetchSurahs() async {
    final response = await http.get(Uri.parse('http://api.alquran.cloud/v1/surah'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        surahs = data['data'];
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
        title: Text('القرآن الكريم'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: surahs.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(surahs[index]['name'], textDirection: TextDirection.rtl),
            subtitle: Text('عدد الآيات: ${surahs[index]['numberOfAyahs']}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SurahPage(
                    surahNumber: surahs[index]['number'],
                    surahName: surahs[index]['name'],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}