import 'package:flutter/material.dart';

import '../l10n/strings.dart';
import '../services/app_settings.dart';
import '../widgets/menu_button.dart';
import 'continent_screen.dart';
import 'game_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
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
                  Icon(Icons.flag_circle_outlined,
                      size: 72, color: scheme.primary),
                  const SizedBox(height: 8),
                  Text(tr('title'),
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall
                          ?.copyWith(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 4),
                  Text(tr('subtitle'),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 28),
                  MenuButton(
                    label: tr('byContinent'),
                    icon: Icons.public,
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const ContinentScreen()),
                    ),
                  ),
                  const SizedBox(height: 12),
                  MenuButton(
                    label: tr('random'),
                    icon: Icons.shuffle,
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const GameScreen()),
                    ),
                  ),
                  const SizedBox(height: 28),
                  const _TimeSelector(),
                  const SizedBox(height: 16),
                  const _DifficultySelector(),
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

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(text,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(fontWeight: FontWeight.w700)),
        ),
      );
}

class _TimeSelector extends StatelessWidget {
  const _TimeSelector();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: AppSettings.seconds,
      builder: (_, selected, __) => Column(
        children: [
          _SectionLabel(tr('time')),
          Align(
            alignment: Alignment.centerLeft,
            child: Wrap(
              spacing: 8,
              children: [
                for (final s in AppSettings.timeOptions)
                  ChoiceChip(
                    label: Text(timeLabel(s)),
                    selected: s == selected,
                    onSelected: (_) => AppSettings.setSeconds(s),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DifficultySelector extends StatelessWidget {
  const _DifficultySelector();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: AppSettings.hard,
      builder: (_, hard, __) => Column(
        children: [
          _SectionLabel(tr('difficulty')),
          SizedBox(
            width: double.infinity,
            child: SegmentedButton<bool>(
              segments: [
                ButtonSegment(value: false, label: Text(tr('easy'))),
                ButtonSegment(value: true, label: Text(tr('hard'))),
              ],
              selected: {hard},
              onSelectionChanged: (s) => AppSettings.setHard(s.first),
            ),
          ),
        ],
      ),
    );
  }
}
