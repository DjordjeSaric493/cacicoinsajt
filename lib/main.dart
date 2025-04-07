import 'package:cacicoinsajt/pages/frontpage.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicijalizacija Supabase-a
  await Supabase.initialize(
    url: 'YOUR_SUPABASE_URL', // Zamenite sa pravim URL-om
    anonKey: 'YOUR_SUPABASE_ANON_KEY', // Zamenite sa pravim anonKey-om
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: FrontPage());
  }
}
