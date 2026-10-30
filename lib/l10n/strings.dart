import '../services/app_settings.dart';

const _t = <String, Map<String, String>>{
  'pt': {
    'title': 'Flag Game',
    'subtitle': 'Você conhece as bandeiras do mundo?',
    'byContinent': 'Jogar por Continente',
    'random': 'Jogo Aleatório',
    'time': 'Tempo de jogo',
    'difficulty': 'Dificuldade',
    'easy': 'Fácil',
    'hard': 'Difícil',
    'language': 'Idioma',
    'chooseContinent': 'Escolha um continente',
    'africa': 'África',
    'america': 'América',
    'asia': 'Ásia',
    'europe': 'Europa',
    'oceania': 'Oceania',
    'score': 'Pontos',
    'correct': 'Acertou!',
    'wrong': 'Errou!',
    'result': 'Resultado',
    'answered': 'Perguntas respondidas',
    'hits': 'Acertos',
    'accuracy': 'Aproveitamento',
    'finalScore': 'Pontuação final',
    'backToMenu': 'Voltar ao menu principal',
    'timeUp': 'Tempo esgotado!',
    'flagError': 'Não foi possível carregar a bandeira',
  },
};

String tr(String key) =>
    _t[AppSettings.lang.value]?[key] ?? _t['pt']![key] ?? key;

String timeLabel(int seconds) =>
    seconds < 60 ? '${seconds}s' : '${seconds ~/ 60} min';
