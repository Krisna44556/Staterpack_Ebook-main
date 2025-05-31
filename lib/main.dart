import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/dashboard/presentation/dashboard_page.dart';
import 'features/auth/presentation/login_page.dart'; // pastikan ini ada

void main() {
  runApp(const ProviderScope(child: SungokongBookApp()));
}

class SungokongBookApp extends StatelessWidget {
  const SungokongBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SUNGOKONG BOOK',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(), // default halaman awal biasanya login
      routes: {
        '/login': (context) => const LoginPage(),
        '/dashboard': (context) => const DashboardPage(),
        // tambahkan routes lain kalau ada
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
