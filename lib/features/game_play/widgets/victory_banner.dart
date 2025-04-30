import 'package:flutter/material.dart';

class VictoryBanner extends StatelessWidget {
  final bool isUndercover;

  const VictoryBanner({super.key, required this.isUndercover});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isUndercover
              ? [Colors.red.shade800, Colors.red.shade400]
              : [Colors.green.shade800, Colors.green.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: const Icon(
        Icons.emoji_events,
        size: 80,
        color: Colors.white,
      ),
    );
  }
}