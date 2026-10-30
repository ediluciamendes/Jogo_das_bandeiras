import 'package:flutter/material.dart';

import '../l10n/strings.dart';
import '../widgets/menu_button.dart';

class ResultScreen extends StatelessWidget {
  final int answered;
  final int correct;

  const ResultScreen({
    super.key,
    required this.answered,
    required this.correct,
  });

  @override
  Widget build(BuildContext context) {
    final pct = answered == 0 ? 0.0 : correct * 100 / answered;
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(tr('result')),
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
                  Icon(Icons.hourglass_bottom, size: 48, color: scheme.primary),
                  const SizedBox(height: 4),
                  Text(tr('timeUp'),
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 20),
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: correct.toDouble()),
                    duration: const Duration(milliseconds: 900),
                    builder: (_, v, __) => Text(
                      v.round().toString(),
                      style: TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.w900,
                          color: scheme.primary),
                    ),
                  ),
                  Text(tr('finalScore')),
                  const SizedBox(height: 24),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          _Row(tr('answered'), '$answered'),
                          _Row(tr('hits'), '$correct'),
                          _Row(tr('accuracy'), '${pct.toStringAsFixed(1)}%'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  MenuButton(
                    label: tr('backToMenu'),
                    icon: Icons.home,
                    onPressed: () =>
                        Navigator.popUntil(context, (route) => route.isFirst),
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

class _Row extends StatelessWidget {
  final String label;
  final String value;
  const _Row(this.label, this.value);

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(label),
        trailing: Text(value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
      );
}
