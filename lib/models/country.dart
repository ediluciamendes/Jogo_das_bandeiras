import '../data/countries_data.dart';

class Country {
  final String code;
  final String continent;
  final bool easy;
  final Map<String, String> _names;

  const Country(this.code, this.continent, this.easy, this._names);

  String name(String lang) => _names[lang] ?? _names['pt']!;

  String get flagUrl => 'https://flagcdn.com/w640/br.png';

  @override
  bool operator ==(Object other) => other is Country && other.code == code;

  @override
  int get hashCode => code.hashCode;
}

const continentKeys = ['africa', 'america', 'asia', 'europe', 'oceania'];

List<Country>? _cache;

List<Country> loadCountries() {
  return _cache ??= countriesRaw
      .trim()
      .split('\n')
      .where((l) => l.trim().isNotEmpty)
      .map((line) {
    final p = line.split(',');
    return Country(p[0], p[1], p[2] == '1', {'pt': p[3]});
  }).toList();
}
