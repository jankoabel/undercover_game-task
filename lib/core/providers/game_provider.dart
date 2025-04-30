import 'package:flutter/material.dart';
import '../constants/game_constants.dart';
import '../constants/word_pairs.dart';
import '../models/game_state.dart';
import '../models/player.dart';
import '../utils/game_logic.dart';

class GameProvider with ChangeNotifier {
  GameState _gameState = GameState(players: []);

  GameState get gameState => _gameState;

  void initializeGame(List<String> playerNames) {
    final players = _createPlayers(playerNames);
    final wordPair = GameLogic.selectRandomWordPair();
    
    _gameState = GameState(
      players: players,
      currentWordPair: wordPair,
      currentPlayer: players.first,
    );
    
    notifyListeners();
  }

  List<Player> _createPlayers(List<String> playerNames) {
    final shuffledNames = List.of(playerNames)..shuffle();
    final players = <Player>[];
    final wordPair = GameLogic.selectRandomWordPair();

    // Assign undercover role to one random player
    final undercoverIndex = GameLogic.getRandomNumber(0, shuffledNames.length - 1);

    for (int i = 0; i < shuffledNames.length; i++) {
      final role = i == undercoverIndex ? PlayerRole.undercover : PlayerRole.citizen;
      final word = role == PlayerRole.undercover ? wordPair.word2 : wordPair.word1;
      
      players.add(Player(
        name: shuffledNames[i],
        role: role,
        word: word,
      ));
    }

    return players;
  }

  void nextPlayer() {
    final currentIndex = _gameState.players.indexOf(_gameState.currentPlayer!);
    var nextIndex = (currentIndex + 1) % _gameState.players.length;
    
    // Skip eliminated players
    while (_gameState.players[nextIndex].isEliminated) {
      nextIndex = (nextIndex + 1) % _gameState.players.length;
    }
    
    _gameState = _gameState.copyWith(
      currentPlayer: _gameState.players[nextIndex],
    );
    
    notifyListeners();
  }

  void voteForPlayer(Player player) {
    final updatedPlayers = _gameState.players.map((p) {
      if (p.name == player.name) {
        return p.copyWith(votes: p.votes + 1);
      }
      return p;
    }).toList();

    _gameState = _gameState.copyWith(players: updatedPlayers);
    notifyListeners();
  }

  void eliminatePlayerWithMostVotes() {
    final players = List.of(_gameState.players);
    players.sort((a, b) => b.votes.compareTo(a.votes));
    
    // Check for tie
    if (players[0].votes == players[1].votes) {
      // No elimination in case of tie
      _resetVotes();
      return;
    }
    
    final eliminatedPlayer = players.first;
    final updatedPlayers = players.map((p) {
      if (p.name == eliminatedPlayer.name) {
        return p.copyWith(isEliminated: true, votes: 0);
      }
      return p.copyWith(votes: 0);
    }).toList();

    _gameState = _gameState.copyWith(
      players: updatedPlayers,
      eliminatedPlayer: eliminatedPlayer,
      currentRound: _gameState.currentRound + 1,
    );

    _gameState.checkWinConditions();
    notifyListeners();
  }

  void _resetVotes() {
    final updatedPlayers = _gameState.players.map((p) => p.copyWith(votes: 0)).toList();
    _gameState = _gameState.copyWith(players: updatedPlayers);
    notifyListeners();
  }

  void resetGame() {
    _gameState = GameState(players: []);
    notifyListeners();
  }
}