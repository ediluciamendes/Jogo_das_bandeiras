import 'package:flutter/material.dart';

/// Botão grande reutilizável usado nos menus.
class MenuButton extends StatelessWidget {
  final String rotulo;
  final VoidCallback aoPressionar;
  final bool preenchido;

  const MenuButton({
    super.key,
    required this.rotulo,
    required this.aoPressionar,
    this.preenchido = true,
  });

  @override
  Widget build(BuildContext context) {
    final child = Text(
      rotulo,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    );
    const espacamento = EdgeInsets.symmetric(vertical: 18, horizontal: 20);
    final forma =
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16));

    return SizedBox(
      width: double.infinity,
      child: preenchido
          ? FilledButton(
              onPressed: aoPressionar,
              style: FilledButton.styleFrom(padding: espacamento, shape: forma),
              child: child,
            )
          : OutlinedButton(
              onPressed: aoPressionar,
              style:
                  OutlinedButton.styleFrom(padding: espacamento, shape: forma),
              child: child,
            ),
    );
  }
}
