const Map<String, String> textos = {
  'titulo': 'Flag Game',
  'subtitulo': 'Você conhece as bandeiras do mundo?',
  'porContinente': 'Jogar por Continente',
  'aleatorio': 'Jogo Aleatório',
  'tempo': 'Tempo de jogo',
  'dificuldade': 'Dificuldade',
  'facil': 'Fácil',
  'dificil': 'Difícil',
  'escolhaContinente': 'Escolha um continente',
  'africa': 'África',
  'america': 'América',
  'asia': 'Ásia',
  'europa': 'Europa',
  'oceania': 'Oceania',
  'pontos': 'Pontos',
  'acertou': 'Acertou!',
  'errou': 'Errou!',
  'resultado': 'Resultado',
  'respondidas': 'Perguntas respondidas',
  'acertos': 'Acertos',
  'aproveitamento': 'Aproveitamento',
  'pontuacaoFinal': 'Pontuação final',
  'voltarMenu': 'Voltar ao menu principal',
  'tempoEsgotado': 'Tempo esgotado!',
  'erroBandeira': 'Não foi possível carregar a bandeira',
};

String tr(String key) {
  return textos[key] ?? key;
}

String rotuloTempo(int segundos) {
  return segundos < 60 ? '${segundos}s' : '${segundos ~/ 60} min';
}
