import 'dart:async';

import 'package:flutter/material.dart';

import '../l10n/strings.dart';
import '../models/country.dart';
import '../services/app_settings.dart';
import 'result_screen.dart';

class GameScreen extends StatefulWidget {
  /// Chave do continente (ex.: 'europe'). Nulo = jogo aleatório (mundo todo).
  final String? continent;

  const GameScreen({super.key, this.continent});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late final int _total;
  late final bool _hard;
  late int _remaining;

  late List<Country> _distractorPool; // de onde saem as opções erradas
  late List<Country> _queue; // bandeiras que serão perguntadas
  int _index = 0;

  late Country _current;
  late List<Country> _options;
  Country? _picked;

  int _answered = 0;
  int _correct = 0;
  bool _finished = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _total = AppSettings.seconds.value;
    _hard = AppSettings.hard.value;
    _remaining = _total;

    final all = loadCountries();
    _distractorPool = widget.continent == null
        ? all
        : all.where((c) => c.continent == widget.continent).toList();

    var questions =
        _hard ? _distractorPool : _distractorPool.where((c) => c.easy).toList();
    if (questions.length < 4) questions = _distractorPool; // fallback
    _queue = List.of(questions)..shuffle();

    _nextQuestion();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_remaining <= 1) {
        setState(() => _remaining = 0);
        _finish();
      } else {
        setState(() => _remaining--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _nextQuestion() {
    if (_index >= _queue.length) {
      _queue.shuffle();
      _index = 0;
    }
    _current = _queue[_index++];
    final wrong = _distractorPool.where((c) => c != _current).toList()
      ..shuffle();
    _options = [...wrong.take(3), _current]..shuffle();
    _picked = null;
  }

  void _answer(Country c) {
    if (_picked != null || _finished) return;
    setState(() {
      _picked = c;
      _answered++;
      if (c == _current) _correct++;
    });
    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted || _finished) return;
      setState(_nextQuestion);
    });
  }

  void _finish() {
    if (_finished) return;
    _finished = true;
    _timer?.cancel();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ResultScreen(
          answered: _answered,
          correct: _correct,
        ),
      ),
    );
  }

  String _clock() {
    final m = _remaining ~/ 60;
    final s = _remaining % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }

  Color? _optionColor(Country c) {
    if (_picked == null) return null;
    if (c == _current) return Colors.green.shade600;
    if (c == _picked) return Colors.red.shade600;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppSettings.lang.value;
    final lowTime = _remaining <= 10;
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.continent == null ? tr('random') : tr(widget.continent!)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: [
                Icon(Icons.timer_outlined, color: lowTime ? Colors.red : null),
                const SizedBox(width: 4),
                Text(_clock(),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: lowTime ? Colors.red : null)),
              ],
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6),
          child: LinearProgressIndicator(
            value: _remaining / _total,
            color: lowTime ? Colors.red : scheme.primary,
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
                  Text('${tr('score')}: $_correct',
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
                        key: ValueKey(_current.code + _answered.toString()),
                        elevation: 4,
                        clipBehavior: Clip.antiAlias,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Image.network(
                                _current.flagUrl,
                                fit: BoxFit.contain,
                                loadingBuilder: (_, child, progress) =>
                                    progress == null
                                        ? child
                                        : const Center(
                                            child: CircularProgressIndicator()),
                                errorBuilder: (_, __, ___) => Center(
                                    child: Text(tr('flagError'),
                                        textAlign: TextAlign.center)),
                              ),
                            ),
                            // Feedback animado de acerto/erro
                            Center(
                              child: AnimatedScale(
                                scale: _picked == null ? 0 : 1,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.elasticOut,
                                child: _picked == null
                                    ? const SizedBox.shrink()
                                    : _Feedback(ok: _picked == _current),
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
                        for (final c in _options)
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: _OptionButton(
                                label: c.name(lang),
                                color: _optionColor(c),
                                onTap: () => _answer(c),
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

class _OptionButton extends StatelessWidget {
  final String label;
  final Color? color;
  final VoidCallback onTap;

  const _OptionButton(
      {required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: double.infinity,
      decoration: BoxDecoration(
        color: color ?? scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: color == null ? null : Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Feedback extends StatelessWidget {
  final bool ok;
  const _Feedback({required this.ok});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color:
            (ok ? Colors.green : Colors.red).shade600.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(ok ? Icons.check_circle : Icons.cancel, color: Colors.white),
          const SizedBox(width: 8),
          Text(ok ? tr('correct') : tr('wrong'),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
