import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Firebase'i başlatıyoruz
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Software Tech',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(), // İlk ekran olarak login ekranı yüklenecek
    );
  }
}
