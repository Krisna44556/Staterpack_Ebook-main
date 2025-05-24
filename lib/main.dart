import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/auth/presentation/login_page.dart';
import 'features/dashboard/dashboard_page.dart'; // pastikan path ini benar
import 'features/auth/domain/auth_provider.dart';
import 'features/loan/loan_history_page.dart';
import 'features/book_list/book_list_page.dart';
import 'models/user_model.dart';
import 'models/book_model.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);

    return MaterialApp(
      title: 'Sungokong Book',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => user == null ? const LoginPage() : const DashboardPage(),
        '/dashboard': (_) => const DashboardPage(),
      },
    );
  }
}
