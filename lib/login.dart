import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'adminhomepage.dart';
import 'ogrencihomepage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Kullanıcı girişini doğrulama ve yönlendirme
  Future<void> _login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Kullanıcı tipini Firestore'dan alıyoruz
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (userDoc.exists) {
        String userType = userDoc['kullanici_tipi'];
        if (userType == 'admin') {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => AdminHomePage()));
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => OgrenciHomePage()));
        }
      }
    } catch (e) {
      print("Giriş Hatası: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Software Tech Giriş'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Kullanıcı Adı'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Şifre'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Giriş Yap'),
            ),
          ],
        ),
      ),
    );
  }
}
