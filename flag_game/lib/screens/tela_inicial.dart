import 'package:flutter/material.dart';

import '../l10n/textos.dart';
import '../services/configuracoes.dart';
import '../widgets/botao_menu.dart';
import 'tela_continentes.dart';
import 'tela_jogo.dart';

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/icone-planeta.jpg', height: 100),
                  const SizedBox(height: 8),
                  Text(tr('titulo'),
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall
                          ?.copyWith(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 4),
                  Text(tr('subtitulo'),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 28),
                  MenuButton(
                    rotulo: tr('porContinente'),
                    aoPressionar: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const TelaContinentes()),
                    ),
                  ),
                  const SizedBox(height: 12),
                  MenuButton(
                    rotulo: tr('aleatorio'),
                    aoPressionar: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const TelaJogo()),
                    ),
                  ),
                  const SizedBox(height: 28),
                  const _SeletorTempo(),
                  const SizedBox(height: 16),
                  const _SeletorDificuldade(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RotuloSecao extends StatelessWidget {
  final String texto;
  const _RotuloSecao(this.texto);

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(texto,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(fontWeight: FontWeight.w700)),
        ),
      );
}

class _SeletorTempo extends StatelessWidget {
  const _SeletorTempo();

  @override
  Widget build(BuildContext context) {
    Object selecionado;
    return ValueListenableBuilder<int>(
      valueListenable: Configuracoes.segundos,
      builder: (_, selecionado, __) => Column(
        children: [
          _RotuloSecao(tr('tempo')),
          Align(
            alignment: Alignment.centerLeft,
            child: Wrap(
              spacing: 8,
              children: [
                for (final s in Configuracoes.opTempo)
                  ChoiceChip(
                    label: Text(rotuloTempo(s)),
                    selected: s == selecionado,
                    onSelected: (_) => Configuracoes.definirSegundos(s),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SeletorDificuldade extends StatelessWidget {
  const _SeletorDificuldade();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: Configuracoes.dificil,
      builder: (_, dificil, __) => Column(
        children: [
          _RotuloSecao(tr('dificuldade')),
          SizedBox(
            width: double.infinity,
            child: SegmentedButton<bool>(
              segments: [
                ButtonSegment(value: false, label: Text(tr('facil'))),
                ButtonSegment(value: true, label: Text(tr('dificil'))),
              ],
              selected: {dificil},
              onSelectionChanged: (s) => Configuracoes.definirDificil(s.first),
            ),
          ),
        ],
      ),
    );
  }
}
