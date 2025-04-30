import 'package:flutter/material.dart';

class SlideTransitionWidget extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Offset begin;
  final Offset end;

  const SlideTransitionWidget({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.begin = const Offset(0, 0.5),
    this.end = Offset.zero,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Offset>(
      tween: Tween(begin: begin, end: end),
      duration: duration,
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Transform.translate(
          offset: value,
          child: child,
        );
      },
      child: child,
    );
  }
}