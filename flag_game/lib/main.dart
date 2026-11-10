import 'package:flutter/material.dart';

import 'screens/tela_inicial.dart';
import 'services/configuracoes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Configuracoes.carregar();
  runApp(const FlagGameApp());
}

class FlagGameApp extends StatelessWidget {
  const FlagGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flag Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(246, 74, 197, 228),
        ),
      ),
      home: const TelaInicial(),
    );
  }
}
