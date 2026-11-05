import 'package:flutter/material.dart';
import 'screens/tela_inicial.dart';
import 'services/configuracoes.dart';

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
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFBBE2F1)),
          scaffoldBackgroundColor: const Color(0xFFFEFEFE), // cor de fundo
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
