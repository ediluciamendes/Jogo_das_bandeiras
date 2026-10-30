import 'package:flutter/material.dart';

/// Botão grande reutilizável usado nos menus.
class MenuButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool filled;

  const MenuButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.filled = true,
  });

  @override
  Widget build(BuildContext context) {
    final child = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon),
        const SizedBox(width: 12),
        Flexible(
          child: Text(label,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        ),
      ],
    );
    const padding = EdgeInsets.symmetric(vertical: 18, horizontal: 20);
    final shape =
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16));

    return SizedBox(
      width: double.infinity,
      child: filled
          ? FilledButton(
              onPressed: onPressed,
              style: FilledButton.styleFrom(padding: padding, shape: shape),
              child: child,
            )
          : OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(padding: padding, shape: shape),
              child: child,
            ),
    );
  }
}
