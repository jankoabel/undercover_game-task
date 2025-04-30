import '../constants/game_constants.dart';
import 'player.dart';
import 'word_pair.dart';

class GameState {
  List<Player> players;
  int currentRound;
  Player? currentPlayer;
  Player? eliminatedPlayer;
  WordPair? currentWordPair;
  bool isGameOver;
  String? winner;

  GameState({
    required this.players,
    this.currentRound = 1,
    this.currentPlayer,
    this.eliminatedPlayer,
    this.currentWordPair,
    this.isGameOver = false,
    this.winner,
  });

  GameState copyWith({
    List<Player>? players,
    int? currentRound,
    Player? currentPlayer,
    Player? eliminatedPlayer,
    WordPair? currentWordPair,
    bool? isGameOver,
    String? winner,
  }) {
    return GameState(
      players: players ?? this.players,
      currentRound: currentRound ?? this.currentRound,
      currentPlayer: currentPlayer ?? this.currentPlayer,
      eliminatedPlayer: eliminatedPlayer ?? this.eliminatedPlayer,
      currentWordPair: currentWordPair ?? this.currentWordPair,
      isGameOver: isGameOver ?? this.isGameOver,
      winner: winner ?? this.winner,
    );
  }

  bool get isUndercoverWon {
    final alivePlayers = players.where((p) => !p.isEliminated).toList();
    return alivePlayers.length <= 2 && 
           alivePlayers.any((p) => p.role == PlayerRole.undercover);
  }

  bool get areCitizensWon {
    final undercover = players.firstWhere(
      (p) => p.role == PlayerRole.undercover && !p.isEliminated,
      orElse: () => Player(name: '', role: PlayerRole.citizen, word: ''),
    );
    return undercover.role != PlayerRole.undercover;
  }

  void checkWinConditions() {
    if (isUndercoverWon) {
      isGameOver = true;
      winner = 'Undercover';
    } else if (areCitizensWon) {
      isGameOver = true;
      winner = 'Citizens';
    }
  }
}