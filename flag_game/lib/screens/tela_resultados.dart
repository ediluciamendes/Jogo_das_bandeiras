import 'package:flutter/material.dart';

import '../l10n/textos.dart';
import '../widgets/botao_menu.dart';

class TelaResultado extends StatelessWidget {
  final int respondidas;
  final int acertos;

  const TelaResultado({
    super.key,
    required this.respondidas,
    required this.acertos,
  });

  @override
  Widget build(BuildContext context) {
    final porcentagem = respondidas == 0 ? 0.0 : acertos * 100 / respondidas;
    final cores = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(tr('resultado')),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.hourglass_bottom, size: 48, color: cores.primary),
                  const SizedBox(height: 4),
                  Text(tr('timeEsgotado'),
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 20),
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: acertos.toDouble()),
                    duration: const Duration(milliseconds: 900),
                    builder: (_, v, __) => Text(
                      v.round().toString(),
                      style: TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.w900,
                          color: cores.primary),
                    ),
                  ),
                  Text(tr('pontuacaoFinal')),
                  const SizedBox(height: 24),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          _Linha(tr('respondidas'), '$respondidas'),
                          _Linha(tr('acertos'), '$acertos'),
                          _Linha(tr('aproveitamento'),
                              '${porcentagem.toStringAsFixed(1)}%'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  MenuButton(
                    rotulo: tr('voltarMenu'),
                    aoPressionar: () =>
                        Navigator.popUntil(context, (rota) => rota.isFirst),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Linha extends StatelessWidget {
  final String rotulo;
  final String valor;
  const _Linha(this.rotulo, this.valor);

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(rotulo),
        trailing: Text(valor,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
      );
}
