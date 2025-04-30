import 'package:flutter/material.dart';
import 'package:undercover/core/constants/app_styles.dart';
import 'package:undercover/core/models/player.dart';
import 'package:undercover/shared/widgets/animated_button.dart';
// app colors
import 'package:undercover/core/constants/app_colors.dart';

class VotingDialog extends StatelessWidget {
  final Player player;
  final VoidCallback onVote;

  const VotingDialog({
    super.key,
    required this.player,
    required this.onVote,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Vote for ${player.name}?',
              style: AppStyles.heading2,
            ),
            const SizedBox(height: 20),
            Text(
              'Do you think ${player.name} is the Undercover?',
              style: AppStyles.bodyText,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: AppStyles.bodyText.copyWith(color: AppColors.textSecondary),
                  ),
                ),
                AnimatedButton(
                  onPressed: () {
                    onVote();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Vote',
                    style: AppStyles.buttonText,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}