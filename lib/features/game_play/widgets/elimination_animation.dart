import 'package:flutter/material.dart';
import 'package:undercover/core/constants/app_styles.dart';
import 'package:undercover/core/models/player.dart';

class EliminationAnimation extends StatelessWidget {
  final Player eliminatedPlayer;

  const EliminationAnimation({
    super.key,
    required this.eliminatedPlayer,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_off,
            size: 80,
            color: AppColors.danger,
          ),
          const SizedBox(height: 20),
          Text(
            '${eliminatedPlayer.name} has been eliminated!',
            style: AppStyles.heading2,
          ),
          const SizedBox(height: 10),
          Text(
            eliminatedPlayer.role == PlayerRole.undercover
                ? 'They were the UNDERCOVER!'
                : 'They were a CITIZEN!',
            style: AppStyles.heading3.copyWith(
              color: eliminatedPlayer.role == PlayerRole.undercover
                  ? AppColors.danger
                  : AppColors.success,
            ),
          ),
        ],
      ),
    );
  }
}