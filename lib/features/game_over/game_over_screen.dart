import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:undercover/core/constants/app_styles.dart';
import 'package:undercover/core/providers/game_provider.dart';
import 'package:undercover/features/game_over/widgets/victory_banner.dart';
import 'package:undercover/shared/widgets/animated_button.dart';

class GameOverScreen extends StatelessWidget {
  const GameOverScreen({super.key});

  static const routeName = '/game_over';

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);
    final winner = gameProvider.gameState.winner;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            VictoryBanner(winner: winner),
            const SizedBox(height: 40),
            Text(
              winner == 'Citizens' 
                  ? 'The Undercover has been found!'
                  : 'The Undercover has survived!',
              style: AppStyles.heading2,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            if (winner == 'Citizens')
              Text(
                'Congratulations to all citizens!',
                style: AppStyles.bodyText,
              ),
            if (winner == 'Undercover')
              Text(
                'The undercover player wins!',
                style: AppStyles.bodyText,
              ),
            const SizedBox(height: 40),
            AnimatedButton(
              onPressed: () {
                gameProvider.resetGame();
                Navigator.pushNamedAndRemoveUntil(
                  context, 
                  '/', 
                  (route) => false,
                );
              },
              child: Text(
                'Play Again',
                style: AppStyles.buttonText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}