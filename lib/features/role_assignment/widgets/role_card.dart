import 'package:flutter/material.dart';
import 'package:undercover/core/constants/app_colors.dart';
import 'package:undercover/core/constants/app_styles.dart';
import 'package:undercover/core/models/player.dart';
import 'package:undercover/shared/widgets/animated_button.dart';

class RoleCard extends StatelessWidget {
  final PlayerRole role;
  final VoidCallback onContinue;

  const RoleCard({
    super.key,
    required this.role,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: role == PlayerRole.undercover 
                ? AppColors.danger.withOpacity(0.2) 
                : AppColors.success.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: role == PlayerRole.undercover 
                  ? AppColors.danger 
                  : AppColors.success,
              width: 2,
            ),
          ),
          child: Column(
            children: [
              Text(
                'You are',
                style: AppStyles.heading3,
              ),
              const SizedBox(height: 10),
              Text(
                role == PlayerRole.undercover ? 'UNDERCOVER' : 'CITIZEN',
                style: AppStyles.heading1.copyWith(
                  color: role == PlayerRole.undercover 
                      ? AppColors.danger 
                      : AppColors.success,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        AnimatedButton(
          onPressed: onContinue,
          child: Text(
            'Continue',
            style: AppStyles.buttonText,
          ),
        ),
      ],
    );
  }
}