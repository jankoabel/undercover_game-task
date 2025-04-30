import 'package:flutter/material.dart';
import 'package:undercover/core/constants/app_styles.dart';
import 'package:undercover/core/models/player.dart';
import 'package:undercover/shared/widgets/animated_button.dart';
// app colors
import 'package:undercover/core/constants/app_colors.dart';

class PlayerTurnIndicator extends StatelessWidget {
  final Player player;
  final VoidCallback onNextPlayer;

  const PlayerTurnIndicator({
    super.key,
    required this.player,
    required this.onNextPlayer,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "It's your turn",
          style: AppStyles.heading2,
        ),
        const SizedBox(height: 20),
        Text(
          player.name,
          style: AppStyles.heading1.copyWith(color: AppColors.primary),
        ),
        const SizedBox(height: 40),
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  'Your word:',
                  style: AppStyles.heading3,
                ),
                const SizedBox(height: 10),
                Text(
                  player.word,
                  style: AppStyles.heading1.copyWith(color: AppColors.primary),
                ),
                const SizedBox(height: 20),
                Text(
                  'Describe this word without saying it',
                  style: AppStyles.caption,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 40),
        AnimatedButton(
          onPressed: onNextPlayer,
          child: Text(
            'Done',
            style: AppStyles.buttonText,
          ),
        ),
      ],
    );
  }
}