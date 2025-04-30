import 'package:flutter/material.dart';
import 'package:undercover/features/game_over/game_over_screen.dart';
import 'package:undercover/features/game_play/game_play_screen.dart';
import 'package:undercover/features/player_setup/player_setup_screen.dart';
import 'package:undercover/features/role_assignment/role_assignment_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const PlayerSetupScreen());
      case RoleAssignmentScreen.routeName:
        return MaterialPageRoute(builder: (_) => const RoleAssignmentScreen());
      case GamePlayScreen.routeName:
        return MaterialPageRoute(builder: (_) => const GamePlayScreen());
      case GameOverScreen.routeName:
        return MaterialPageRoute(builder: (_) => const GameOverScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}