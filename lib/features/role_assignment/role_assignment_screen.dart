import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:undercover/core/constants/app_styles.dart';
import 'package:undercover/core/models/player.dart';
import 'package:undercover/core/providers/game_provider.dart';
import 'package:undercover/features/role_assignment/widgets/role_card.dart';
import 'package:undercover/features/role_assignment/widgets/word_reveal.dart';
import 'package:undercover/shared/widgets/animated_button.dart';
//app colors
import 'package:undercover/core/constants/app_colors.dart';

class RoleAssignmentScreen extends StatefulWidget {
  const RoleAssignmentScreen({super.key});

  static const routeName = '/role_assignment';

  @override
  State<RoleAssignmentScreen> createState() => _RoleAssignmentScreenState();
}

class _RoleAssignmentScreenState extends State<RoleAssignmentScreen> {
  int _currentPlayerIndex = 0;
  bool _showRole = false;
  bool _showWord = false;

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);
    final players = gameProvider.gameState.players;
    final currentPlayer = players[_currentPlayerIndex];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Pass the device to',
              style: AppStyles.heading2,
            ),
            const SizedBox(height: 20),
            Text(
              currentPlayer.name,
              style: AppStyles.heading1.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 40),
            if (!_showRole && !_showWord)
              AnimatedButton(
                onPressed: () => setState(() => _showRole = true),
                child: Text(
                  'Reveal Role',
                  style: AppStyles.buttonText,
                ),
              ),
            if (_showRole && !_showWord)
              RoleCard(
                role: currentPlayer.role,
                onContinue: () => setState(() => _showWord = true),
              ),
            if (_showWord)
              WordReveal(
                word: currentPlayer.word,
                onContinue: () {
                  setState(() {
                    _showRole = false;
                    _showWord = false;
                  });
                  _nextPlayer(gameProvider, players);
                },
              ),
          ],
        ),
      ),
    );
  }

  void _nextPlayer(GameProvider gameProvider, List<Player> players) {
    if (_currentPlayerIndex < players.length - 1) {
      setState(() => _currentPlayerIndex++);
    } else {
      Navigator.pushNamed(context, '/game_play');
    }
  }
}