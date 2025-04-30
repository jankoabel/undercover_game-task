import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:undercover/core/constants/app_styles.dart';
import 'package:undercover/core/constants/game_constants.dart';
import 'package:undercover/core/providers/game_provider.dart';
import 'package:undercover/features/player_setup/widgets/player_count_selector.dart';
import 'package:undercover/features/player_setup/widgets/player_input_field.dart';
import 'package:undercover/shared/widgets/animated_button.dart';
// app colors 
import 'package:undercover/core/constants/app_colors.dart';

class PlayerSetupScreen extends StatefulWidget {
  const PlayerSetupScreen({super.key});

  @override
  State<PlayerSetupScreen> createState() => _PlayerSetupScreenState();
}

class _PlayerSetupScreenState extends State<PlayerSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  int _playerCount = GameConstants.minPlayers;
  final List<TextEditingController> _playerControllers = [];

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _playerControllers.clear();
    for (int i = 0; i < _playerCount; i++) {
      _playerControllers.add(TextEditingController());
    }
  }

  void _handlePlayerCountChange(int newCount) {
    setState(() {
      _playerCount = newCount;
      _initializeControllers();
    });
  }

  void _handleCSVInput(String csv) {
    final names = csv.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    if (names.length >= GameConstants.minPlayers && names.length <= GameConstants.maxPlayers) {
      setState(() {
        _playerCount = names.length;
        _initializeControllers();
        for (int i = 0; i < names.length && i < _playerControllers.length; i++) {
          _playerControllers[i].text = names[i];
        }
      });
    }
  }

  void _startGame() {
    if (_formKey.currentState!.validate()) {
      final playerNames = _playerControllers.map((c) => c.text).toList();
      Provider.of<GameProvider>(context, listen: false).initializeGame(playerNames);
      Navigator.pushNamed(context, '/role_assignment');
    }
  }

  @override
  void dispose() {
    for (var controller in _playerControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              Text(
                'Undercover',
                style: AppStyles.heading1.copyWith(color: AppColors.primary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                'Enter player names',
                style: AppStyles.heading2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              PlayerCountSelector(
                playerCount: _playerCount,
                onChanged: _handlePlayerCountChange,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _playerCount,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: PlayerInputField(
                        controller: _playerControllers[index],
                        playerNumber: index + 1,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => _showCSVInputDialog(),
                child: Text(
                  'Or paste comma-separated names',
                  style: AppStyles.caption.copyWith(color: AppColors.accent),
                ),
              ),
              const SizedBox(height: 20),
              AnimatedButton(
                onPressed: _startGame,
                child: Text(
                  'Start Game',
                  style: AppStyles.buttonText,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _showCSVInputDialog() {
    final csvController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter player names'),
          content: TextField(
            controller: csvController,
            decoration: const InputDecoration(
              hintText: 'Name1, Name2, Name3, ...',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _handleCSVInput(csvController.text);
                Navigator.pop(context);
              },
              child: const Text('Apply'),
            ),
          ],
        );
      },
    ).then((_) => csvController.dispose());
  }
}