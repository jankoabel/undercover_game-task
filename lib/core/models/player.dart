enum PlayerRole { citizen, undercover }

class Player {
  final String name;
  final PlayerRole role;
  final String word;
  bool isEliminated;
  int votes;

  Player({
    required this.name,
    required this.role,
    required this.word,
    this.isEliminated = false,
    this.votes = 0,
  });

  Player copyWith({
    String? name,
    PlayerRole? role,
    String? word,
    bool? isEliminated,
    int? votes,
  }) {
    return Player(
      name: name ?? this.name,
      role: role ?? this.role,
      word: word ?? this.word,
      isEliminated: isEliminated ?? this.isEliminated,
      votes: votes ?? this.votes,
    );
  }
}