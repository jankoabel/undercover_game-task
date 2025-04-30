import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:undercover/core/constants/app_styles.dart';
import 'package:undercover/core/models/game_state.dart';
import 'package:undercover/core/providers/game_provider.dart';
import 'package:undercover/features/game_play/widgets/player_turn_indicator.dart';
import 'package:undercover/features/game_play/widgets/voting_dialog.dart';
import 'package:undercover/core/models/player.dart';
import 'package:undercover/shared/widgets/animated_button.dart';



class GamePlayScreen extends StatefulWidget {
  const GamePlayScreen({super.key});

  static const routeName = '/game_play';

  @override
  State<GamePlayScreen> createState() => _GamePlayScreenState();
}

class _GamePlayScreenState extends State<GamePlayScreen> {
  bool _isVotingPhase = false;

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);
    final gameState = gameProvider.gameState;

    if (gameState.isGameOver) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(context, '/game_over');
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Round ${gameState.currentRound}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showGameInfo(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (!_isVotingPhase)
              Expanded(
                child: PlayerTurnIndicator(
                  player: gameState.currentPlayer!,
                  onNextPlayer: () {
                    gameProvider.nextPlayer();
                    // Check if all players have spoken
                    if (gameState.currentPlayer == gameState.players.firstWhere((p) => !p.isEliminated)) {
                      setState(() => _isVotingPhase = true);
                    }
                  },
                ),
              ),
            if (_isVotingPhase)
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Time to vote!',
                      style: AppStyles.heading2,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Who do you think is the Undercover?',
                      style: AppStyles.bodyText,
                    ),
                    const SizedBox(height: 30),
                    Expanded(
                      child: ListView.builder(
                        itemCount: gameState.players.length,
                        itemBuilder: (context, index) {
                          final player = gameState.players[index];
                          if (player.isEliminated) return const SizedBox();
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              title: Text(player.name),
                              trailing: Text('Votes: ${player.votes}'),
                              onTap: () => _showVoteDialog(context, player),
                            ),
                          );
                        },
                      ),
                    ),
                    AnimatedButton(
                      onPressed: () {
                        gameProvider.eliminatePlayerWithMostVotes();
                        setState(() => _isVotingPhase = false);
                      },
                      child: Text(
                        'Eliminate Player',
                        style: AppStyles.buttonText,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showVoteDialog(BuildContext context, Player player) {
    showDialog(
      context: context,
      builder: (context) => VotingDialog(
        player: player,
        onVote: () {
          Provider.of<GameProvider>(context, listen: false).voteForPlayer(player);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showGameInfo(BuildContext context) {
    final gameState = Provider.of<GameProvider>(context, listen: false).gameState;
    final alivePlayers = gameState.players.where((p) => !p.isEliminated).length;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Game Info'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Round: ${gameState.currentRound}'),
            Text('Players remaining: $alivePlayers'),
            const SizedBox(height: 10),
            const Text('Rules:'),
            const Text('- Citizens and Undercover get similar words'),
            const Text('- Describe your word without saying it'),
            const Text('- Vote to eliminate the Undercover'),
            const Text('- Undercover wins if only 2 players remain'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}