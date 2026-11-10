import 'dart:async';

import 'package:flutter/material.dart';

import '../l10n/textos.dart';
import '../models/paises.dart';
import '../services/configuracoes.dart';
import 'tela_resultados.dart';

class TelaJogo extends StatefulWidget {
  /// Chave do continente (ex.: 'europe'). Nulo = jogo aleatório (mundo todo).
  final String? continente;

  const TelaJogo({super.key, this.continente});

  @override
  State<TelaJogo> createState() => _EstadoTelaJogo();
}

class _EstadoTelaJogo extends State<TelaJogo> {
  late final int _total;
  late final bool _dificil;
  late int _restante;

  late List<Pais> _grupo; // de onde saem as opções erradas
  late List<Pais> _fila; // paises que serão perguntados
  int _index = 0;

  late Pais _atual;
  late List<Pais> _opcoes;
  Pais? _escolhido;

  int _respondidas = 0;
  int _acertos = 0;
  bool _terminou = false;
  Timer? _cronometro;

  @override
  void initState() {
    super.initState();
    _total = Configuracoes.segundos.value;
    _dificil = Configuracoes.dificil.value;
    _restante = _total;

    final todos = carregarPaises();
    _grupo = widget.continente == null
        ? todos
        : todos.where((p) => p.continente == widget.continente).toList();

    var perguntas = _dificil ? _grupo : _grupo.where((p) => p.facil).toList();
    if (perguntas.length < 4) perguntas = _grupo; // fallback
    _fila = List.of(perguntas)..shuffle();

    _proximaPergunta();
    _cronometro = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_restante <= 1) {
        setState(() => _restante = 0);
        _terminar();
      } else {
        setState(() => _restante--);
      }
    });
  }

  @override
  void dispose() {
    _cronometro?.cancel();
    super.dispose();
  }

  void _proximaPergunta() {
    if (_index >= _fila.length) {
      _fila.shuffle();
      _index = 0;
    }
    _atual = _fila[_index++];
    final erradas = _grupo.where((p) => p != _atual).toList()..shuffle();
    _opcoes = [...erradas.take(3), _atual]..shuffle();
    _escolhido = null;
  }

  void _responder(Pais pais) {
    if (_escolhido != null || _terminou) return;
    setState(() {
      _escolhido = pais;
      _respondidas++;
      if (pais == _atual) _acertos++;
    });
    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted || _terminou) return;
      setState(_proximaPergunta);
    });
  }

  void _terminar() {
    if (_terminou) return;
    _terminou = true;
    _cronometro?.cancel();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => TelaResultado(
          respondidas: _respondidas,
          acertos: _acertos,
        ),
      ),
    );
  }

  String _relogio() {
    final m = _restante ~/ 60;
    final s = _restante % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }

  Color? _opCor(Pais p) {
    if (_escolhido == null) return null;
    if (p == _atual) return Colors.green.shade600;
    if (p == _escolhido) return Colors.red.shade600;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final pouco = _restante <= 10;
    final cores = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.continente == null
            ? tr('aleatorio')
            : tr(widget.continente!)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: [
                Icon(Icons.timer_outlined, color: pouco ? Colors.red : null),
                const SizedBox(width: 4),
                Text(_relogio(),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: pouco ? Colors.red : null)),
              ],
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6),
          child: LinearProgressIndicator(
            value: _restante / _total,
            color: pouco ? Colors.red : cores.primary,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text('${tr('pontos')}: $_acertos',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 12),
                  // Bandeira no topo
                  Expanded(
                    flex: 4,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Card(
                        key: ValueKey(_atual.code + _respondidas.toString()),
                        elevation: 4,
                        clipBehavior: Clip.antiAlias,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Image.network(
                                _atual.flagUrl,
                                fit: BoxFit.contain,
                                loadingBuilder: (_, child, progresso) =>
                                    progresso == null
                                        ? child
                                        : const Center(
                                            child: CircularProgressIndicator()),
                                errorBuilder: (_, __, ___) => Center(
                                    child: Text(tr('erroBandeira'),
                                        textAlign: TextAlign.center)),
                              ),
                            ),
                            // Feedback animado de acerto/erro
                            Center(
                              child: AnimatedScale(
                                scale: _escolhido == null ? 0 : 1,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.elasticOut,
                                child: _escolhido == null
                                    ? const SizedBox.shrink()
                                    : _Aviso(acertou: _escolhido == _atual),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Quatro opções de resposta
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        for (final p in _opcoes)
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: _OpButao(
                                rotulo: p.name(),
                                cor: _opCor(p),
                                aoTocar: () => _responder(p),
                              ),
                            ),
                          ),
                      ],
                    ),
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

class _OpButao extends StatelessWidget {
  final String rotulo;
  final Color? cor;
  final VoidCallback aoTocar;

  const _OpButao(
      {required this.rotulo, required this.cor, required this.aoTocar});

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: double.infinity,
      decoration: BoxDecoration(
        color: cor ?? cores.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: aoTocar,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                rotulo,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: cor == null ? null : Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Aviso extends StatelessWidget {
  final bool acertou;
  const _Aviso({required this.acertou});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: (acertou ? Colors.green : Colors.red)
            .shade600
            .withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(acertou ? Icons.check_circle : Icons.cancel,
              color: Colors.white),
          const SizedBox(width: 8),
          Text(acertou ? tr('acertou') : tr('errou'),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
