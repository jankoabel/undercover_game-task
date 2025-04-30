import 'package:flutter/material.dart';
import '../models/game_state.dart';
import '../models/player.dart';
import '../utils/game_logic.dart';

class GameProvider with ChangeNotifier {
  GameState? _gameState;

  GameState? get gameState => _gameState;

  void initializeGame(List<String> playerNames) {
    final gameSetup = GameLogic.setupGame(playerNames);
    _gameState = GameState(players: gameSetup.players);
    notifyListeners();
  }

  void nextTurn() {
    if (_gameState == null || _gameState!.isGameOver) return;

    final currentIndex = _gameState!.currentPlayerTurn;
    final activePlayers = _gameState!.players.where((p) => !p.isEliminated).toList();
    
    int nextIndex = (currentIndex + 1) % activePlayers.length;
    
    _gameState = _gameState!.copyWith(currentPlayerTurn: nextIndex);
    notifyListeners();
  }

  void votePlayer(String playerId) {
    if (_gameState == null) return;

    final updatedPlayers = _gameState!.players.map((player) {
      if (player.id == playerId) {
        return player.copyWith(votesAgainst: player.votesAgainst + 1);
      }
      return player;
    }).toList();

    _gameState = _gameState!.copyWith(players: updatedPlayers);
    notifyListeners();
  }

  void eliminatePlayer() {
    if (_gameState == null) return;

    final players = _gameState!.players;
    final maxVotes = players.fold(0, (max, p) => p.votesAgainst > max ? p.votesAgainst : max);
    final candidates = players.where((p) => p.votesAgainst == maxVotes).toList();

    // Handle tie (no elimination)
    if (candidates.length > 1) {
      _gameState = _gameState!.copyWith(
        currentRound: _gameState!.currentRound + 1,
        currentPlayerTurn: 0,
      );
      resetVotes();
      return;
    }

    final eliminated = candidates.first;
    final updatedPlayers = players.map((p) {
      if (p.id == eliminated.id) {
        return p.copyWith(isEliminated: true);
      }
      return p;
    }).toList();

    // Check win conditions
    final remainingPlayers = updatedPlayers.where((p) => !p.isEliminated).toList();
    final undercoverCount = remainingPlayers.where((p) => p.isUndercover).length;
    bool isGameOver = false;
    Player? winner;

    if (undercoverCount == 0) {
      // Citizens win
      isGameOver = true;
      winner = remainingPlayers.firstWhere((p) => !p.isUndercover);
    } else if (remainingPlayers.length <= 2) {
      // Undercover wins
      isGameOver = true;
      winner = remainingPlayers.firstWhere((p) => p.isUndercover);
    }

    _gameState = _gameState!.copyWith(
      players: updatedPlayers,
      currentRound: _gameState!.currentRound + 1,
      currentPlayerTurn: 0,
      isGameOver: isGameOver,
      winner: winner,
    );

    resetVotes();
    notifyListeners();
  }

  void resetVotes() {
    if (_gameState == null) return;

    final updatedPlayers = _gameState!.players.map((player) {
      return player.copyWith(votesAgainst: 0);
    }).toList();

    _gameState = _gameState!.copyWith(players: updatedPlayers);
    notifyListeners();
  }
}