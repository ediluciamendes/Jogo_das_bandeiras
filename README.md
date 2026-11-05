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
  data/dados_paises.dart        # banco de dados
  models/paises.dart
  l10n/textos.dart               # traduções
  services/configuracoes.dart      # tempo, dificuldade 
  screens/ inicial, continentes, jogo, resultados
  widgets/botao_menu.dart
```

