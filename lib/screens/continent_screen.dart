import 'package:flutter/material.dart';

import '../l10n/strings.dart';
import '../models/country.dart';
import '../widgets/menu_button.dart';
import 'game_screen.dart';

class ContinentScreen extends StatelessWidget {
  const ContinentScreen({super.key});

  static const _icons = {
    'africa': Icons.terrain,
    'america': Icons.travel_explore,
    'asia': Icons.temple_buddhist_outlined,
    'europe': Icons.castle_outlined,
    'oceania': Icons.surfing,
  };

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
                  icon: _icons[key]!,
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
