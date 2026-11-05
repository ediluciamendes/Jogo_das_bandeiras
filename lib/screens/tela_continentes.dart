import 'package:flutter/material.dart';

import '../l10n/textos.dart';
import '../models/paises.dart';
import '../widgets/botao_menu.dart';
import 'tela_jogo.dart';

class ContinentScreen extends StatelessWidget {
  const ContinentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr('chooseContinent'))),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              for (final key in continentKeys) ...[
                MenuButton(
                  label: tr(key),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => GameScreen(continent: key)),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
