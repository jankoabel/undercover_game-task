import 'package:flutter/material.dart';
import 'package:undercover/core/constants/app_styles.dart';
import 'package:undercover/core/constants/game_constants.dart';
// app colors
import 'package:undercover/core/constants/app_colors.dart';

class PlayerCountSelector extends StatelessWidget {
  final int playerCount;
  final Function(int) onChanged;

  const PlayerCountSelector({
    super.key,
    required this.playerCount,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Number of players: $playerCount',
          style: AppStyles.heading3,
        ),
        const SizedBox(height: 8),
        Slider(
          value: playerCount.toDouble(),
          min: GameConstants.minPlayers.toDouble(),
          max: GameConstants.maxPlayers.toDouble(),
          divisions: GameConstants.maxPlayers - GameConstants.minPlayers,
          label: playerCount.toString(),
          onChanged: (value) => onChanged(value.toInt()),
          activeColor: AppColors.primary,
          inactiveColor: AppColors.secondary,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${GameConstants.minPlayers}',
              style: AppStyles.caption,
            ),
            Text(
              '${GameConstants.maxPlayers}',
              style: AppStyles.caption,
            ),
          ],
        ),
      ],
    );
  }
}