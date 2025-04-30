class Player {
  final String id;
  final String name;
  final bool isUndercover;
  final String word;
  bool isEliminated;
  int votesAgainst;

  Player({
    required this.id,
    required this.name,
    required this.isUndercover,
    required this.word,
    this.isEliminated = false,
    this.votesAgainst = 0,
  });

  Player copyWith({
    bool? isEliminated,
    int? votesAgainst,
  }) {
    return Player(
      id: id,
      name: name,
      isUndercover: isUndercover,
      word: word,
      isEliminated: isEliminated ?? this.isEliminated,
      votesAgainst: votesAgainst ?? this.votesAgainst,
    );
  }
}