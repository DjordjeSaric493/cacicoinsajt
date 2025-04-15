import 'package:cacicoinsajt/pages/cacilend.dart';
import 'package:cacicoinsajt/pages/frontpage.dart';
import 'package:cacicoinsajt/pages/nebudicaci.dart';
import 'package:cacicoinsajt/pages/opiscacija.dart';
import 'package:cacicoinsajt/utils/text/appstrings.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicijalizacija Supabase-a
  await Supabase.initialize(
    //TODO:!!!!
    url:
        'https://hstbygknwbgvfsdopkhd.supabase.co', // Zamenite sa pravim URL-om
    anonKey: AppStringsEng.anonkey, // Zamenite sa pravim anonKey-om
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/', // Postavite početnu rutu
      routes: {
        '/': (context) => const FrontPage(), // Ruta za početnu stranicu
        '/cacicoin':
            (context) => const FrontPage(), // Ruta za ĆaciCoin stranicu
        '/nebudicaci':
            (context) =>
                const NebudiCaciScreen(), // Ruta za Ne Budi Ćaci stranicu
        '/opiscacija':
            (context) =>
                const OpiscacijaScreen(), // Ruta za Ne Budi Ćaci stranicu
        '/cacilend': (context) => const Cacilend(),
      },
    );
  }
}
