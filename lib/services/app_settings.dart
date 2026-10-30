import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings {
  static final ValueNotifier<String> lang = ValueNotifier('pt');
  static final ValueNotifier<int> seconds = ValueNotifier(60);
  static final ValueNotifier<bool> hard = ValueNotifier(false);

  static const timeOptions = [30, 60, 180, 300];

  static Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    lang.value = 'pt';
    final s = prefs.getInt('seconds') ?? 60;
    seconds.value = timeOptions.contains(s) ? s : 60;
    hard.value = prefs.getBool('hard') ?? false;
  }

  static Future<void> setLang(String v) async {
    lang.value = v;
    (await SharedPreferences.getInstance()).setString('lang', v);
  }

  static Future<void> setSeconds(int v) async {
    seconds.value = v;
    (await SharedPreferences.getInstance()).setInt('seconds', v);
  }

  static Future<void> setHard(bool v) async {
    hard.value = v;
    (await SharedPreferences.getInstance()).setBool('hard', v);
  }
}
