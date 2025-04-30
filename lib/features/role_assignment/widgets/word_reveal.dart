import 'package:flutter/material.dart';
import 'package:undercover/core/constants/app_colors.dart';
import 'package:undercover/core/constants/app_styles.dart';
import 'package:undercover/shared/widgets/animated_button.dart';

class WordReveal extends StatelessWidget {
  final String word;
  final VoidCallback onContinue;

  const WordReveal({
    super.key,
    required this.word,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.primary,
              width: 2,
            ),
          ),
          child: Column(
            children: [
              Text(
                'Your word is',
                style: AppStyles.heading3,
              ),
              const SizedBox(height: 10),
              Text(
                word,
                style: AppStyles.heading1.copyWith(color: AppColors.primary),
              ),
              const SizedBox(height: 10),
              Text(
                'Describe this word without saying it',
                style: AppStyles.caption,
                textAlign: TextAlign.center,
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