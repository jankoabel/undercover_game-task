import '../constants/word_pairs.dart' as word_data;
import '../models/word_pair.dart';
import 'dart:math';


class GameLogic {
  static final Random _random = Random();

  static WordPair selectRandomWordPair() {
    if (word_data.WordPairs.pairs.isEmpty) {
      throw StateError('Word pairs list is empty');
    }
    final index = _random.nextInt(word_data.WordPairs.pairs.length);
    return word_data.WordPairs.pairs[index];
  }

  static int getRandomNumber(int min, int max) {
    if (min > max) {
      throw ArgumentError('min should be less than or equal to max');
    }
    return min + _random.nextInt(max - min + 1);
  }
}
