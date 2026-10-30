import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'services/app_settings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSettings.load();
  runApp(const FlagGameApp());
}

class FlagGameApp extends StatelessWidget {
  const FlagGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: AppSettings.lang,
      builder: (_, lang, __) => MaterialApp(
        key: ValueKey(lang),
        title: 'Flag Game',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(246, 74, 197, 228)),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
