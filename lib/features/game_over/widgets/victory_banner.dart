import 'package:flutter/material.dart';
import 'package:undercover/core/constants/app_colors.dart';
import 'package:undercover/core/constants/app_styles.dart';
import 'package:undercover/shared/widgets/slide_transition.dart';

class VictoryBanner extends StatelessWidget {
  final String? winner;

  const VictoryBanner({super.key, required this.winner});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      decoration: BoxDecoration(
        color: winner == 'Citizens' 
            ? AppColors.success.withOpacity(0.2) 
            : AppColors.danger.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: winner == 'Citizens' ? AppColors.success : AppColors.danger,
          width: 2,
        ),
      ),
      child: SlideTransitionWidget(
        child: Column(
          children: [
            Text(
              'GAME OVER',
              style: AppStyles.heading3,
            ),
            const SizedBox(height: 10),
            Text(
              winner == 'Citizens' ? 'CITIZENS WIN!' : 'UNDERCOVER WINS!',
              style: AppStyles.heading1.copyWith(
                color: winner == 'Citizens' ? AppColors.success : AppColors.danger,
              ),
            ),
          ],
        ),
      ),
    );
  }
}