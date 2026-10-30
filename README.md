# Flag Game 🚩

É UM App em Flutter para testar seus conhecimentos sobre bandeiras do mundo.

## Funcionalidades

- **Menu principal**: Jogar por Continente, Jogo Aleatório e configuração de tempo (30 s, 60 s, 3 min, 5 min).
- **Tela de jogo**: bandeira no topo, 4 opções, cronômetro regressivo, feedback de acerto/erro e avanço automático.
- **Resultados**: perguntas respondidas, acertos, percentual e botão para voltar ao menu.
- **Extras**: dificuldade (fácil/difícil) e animações.

## Estrutura

```
lib/
  main.dart
  data/countries_data.dart        # banco de dados (código, continente, nomes pt/en/es)
  models/country.dart
  l10n/strings.dart               # traduções
  services/app_settings.dart      # idioma, tempo, dificuldade (persistidos)
  services/leaderboard_service.dart
  screens/ home, continent, game, result, leaderboard
  widgets/menu_button.dart
```

