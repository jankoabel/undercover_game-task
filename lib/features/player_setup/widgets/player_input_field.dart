import 'package:flutter/material.dart';
import 'package:undercover/core/constants/app_styles.dart';
import 'package:undercover/core/constants/app_colors.dart';

class PlayerInputField extends StatelessWidget {
  final TextEditingController controller;
  final int playerNumber;

  const PlayerInputField({
    super.key,
    required this.controller,
    required this.playerNumber,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Player $playerNumber',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: AppColors.surface.withOpacity(0.5),
      ),
      style: AppStyles.bodyText,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a name';
        }
        return null;
      },
    );
  }
}