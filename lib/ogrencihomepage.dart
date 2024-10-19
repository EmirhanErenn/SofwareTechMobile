import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OgrenciHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Öğrenci Anasayfa'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('notlar').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return DataTable(
            columns: [
              DataColumn(label: Text('Ders Kodu')),
              DataColumn(label: Text('Ara Sınav 1')),
              DataColumn(label: Text('Vize')),
              DataColumn(label: Text('Final')),
            ],
            rows: snapshot.data!.docs.map((doc) {
              return DataRow(cells: [
                DataCell(Text(doc['ders_kod'].toString())),
                DataCell(Text(doc['arasınav1'].toString())),
                DataCell(Text(doc['vize'].toString())),
                DataCell(Text(doc['final'].toString())),
              ]);
            }).toList(),
          );
        },
      ),
    );
  }
}
