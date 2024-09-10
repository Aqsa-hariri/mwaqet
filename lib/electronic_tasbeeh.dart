import 'package:flutter/material.dart';

class ElectronicTasbeeh extends StatefulWidget {
  @override
  _ElectronicTasbeehState createState() => _ElectronicTasbeehState();
}

class _ElectronicTasbeehState extends State<ElectronicTasbeeh> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('السبحة الإلكترونية'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'عدد التسبيحات:',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              '$_counter',
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: Text('+', style: TextStyle(fontSize: 24)),
                  onPressed: _incrementCounter,
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  child: Text('إعادة ضبط', style: TextStyle(fontSize: 24)),
                  onPressed: _resetCounter,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
