import 'package:flutter/material.dart';
import 'package:sistem_akademik/home.dart'; // <-- 1. IMPORT FILE BARU

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sistem Akademik',
      home: HomePage(), // <-- 2. GUNAKAN WIDGET DARI FILE BARU
    );
  }
}