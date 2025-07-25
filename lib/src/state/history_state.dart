import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class HistoryState extends ChangeNotifier {
  final history = <WordPair>[];
  GlobalKey? historyListKey; // This key now belongs to HistoryState's domain

  void addHistoryItem(WordPair pair) {
    history.insert(0, pair);
    // Use the key to interact with the AnimatedList for animation
    var animatedList = historyListKey?.currentState as AnimatedListState?;
    animatedList?.insertItem(0);
    notifyListeners(); // Notify if something directly watches historyState
  }

// You could add other history-related methods here if needed (e.g., clearHistory)
}