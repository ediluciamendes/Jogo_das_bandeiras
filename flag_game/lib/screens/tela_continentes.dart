import 'package:flutter/material.dart';

import '../l10n/textos.dart';
import '../models/paises.dart';
import '../widgets/botao_menu.dart';
import 'tela_jogo.dart';

class TelaContinentes extends StatelessWidget {
  const TelaContinentes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr('escolhaContinente'))),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              for (final key in chavesContinentes) ...[
                MenuButton(
                  rotulo: tr(key),
                  aoPressionar: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => TelaJogo(continente: key)),
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
