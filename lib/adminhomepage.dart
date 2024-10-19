import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminHomePage extends StatefulWidget {
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  final TextEditingController _dersKodController = TextEditingController();
  final TextEditingController _araSinav1Controller = TextEditingController();
  final TextEditingController _vizeController = TextEditingController();
  final TextEditingController _finalController = TextEditingController();

  // Not ekleme fonksiyonu
  Future<void> _addGrade() async {
    try {
      await FirebaseFirestore.instance.collection('notlar').add({
        'ders_kod': _dersKodController.text,
        'arasınav1': int.parse(_araSinav1Controller.text),
        'vize': int.parse(_vizeController.text),
        'final': int.parse(_finalController.text),
      });
      print('Not Eklendi');
    } catch (e) {
      print('Hata: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Paneli'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _dersKodController,
              decoration: InputDecoration(labelText: 'Ders Kodu'),
            ),
            TextField(
              controller: _araSinav1Controller,
              decoration: InputDecoration(labelText: 'Ara Sınav 1'),
            ),
            TextField(
              controller: _vizeController,
              decoration: InputDecoration(labelText: 'Vize'),
            ),
            TextField(
              controller: _finalController,
              decoration: InputDecoration(labelText: 'Final'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addGrade,
              child: Text('Not Ekle'),
            ),
          ],
        ),
      ),
    );
  }
}
