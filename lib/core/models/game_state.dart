class GameState {
  final List<Player> players;
  final int currentRound;
  final int currentPlayerTurn;
  final bool isGameOver;
  final Player? winner;

  GameState({
    required this.players,
    this.currentRound = 1,
    this.currentPlayerTurn = 0,
    this.isGameOver = false,
    this.winner,
  });

  GameState copyWith({
    List<Player>? players,
    int? currentRound,
    int? currentPlayerTurn,
    bool? isGameOver,
    Player? winner,
  }) {
    return GameState(
      players: players ?? this.players,
      currentRound: currentRound ?? this.currentRound,
      currentPlayerTurn: currentPlayerTurn ?? this.currentPlayerTurn,
      isGameOver: isGameOver ?? this.isGameOver,
      winner: winner ?? this.winner,
    );
  }
}