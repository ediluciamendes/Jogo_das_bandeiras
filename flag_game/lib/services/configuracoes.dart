import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Configuracoes {
  static final ValueNotifier<int> segundos = ValueNotifier(60);
  static final ValueNotifier<bool> dificil = ValueNotifier(false);

  static const opTempo = [30, 60, 180, 300];

  static Future<void> carregar() async {
    final prefs = await SharedPreferences.getInstance();
    final s = prefs.getInt('segundos') ?? 60;
    segundos.value = opTempo.contains(s) ? s : 60;
    dificil.value = prefs.getBool('dificil') ?? false;
  }

  static Future<void> definirSegundos(int v) async {
    segundos.value = v;
    await (await SharedPreferences.getInstance()).setInt('segundos', v);
  }

  static Future<void> definirDificil(bool v) async {
    dificil.value = v;
    await (await SharedPreferences.getInstance()).setBool('dificil', v);
  }
}
