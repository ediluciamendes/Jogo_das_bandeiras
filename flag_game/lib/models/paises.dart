import '../data/dados_paises.dart';

class Pais {
  final String code;
  final String continente;
  final bool facil;
  final Map<String, String> _nome;

  const Pais(this.code, this.continente, this.facil, this._nome);

  String name() => _nome['pt']!;

  String get flagUrl => 'https://flagcdn.com/w640/$code.png';

  @override
  bool operator ==(Object other) => other is Pais && other.code == code;

  @override
  int get hashCode => code.hashCode;
}

const chavesContinentes = ['africa', 'america', 'asia', 'europa', 'oceania'];

List<Pais>? _cache;

List<Pais> carregarPaises() {
  return _cache ??= bancoPaises
      .trim()
      .split('\n')
      .where((l) => l.trim().isNotEmpty)
      .map((linha) {
    final p = linha.split(',');
    return Pais(p[0], p[1], p[2] == '1', {'pt': p[3]});
  }).toList();
}
