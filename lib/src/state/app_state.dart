import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:belajar/src/state/history_state.dart';

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  var favorites = <WordPair>[];

  void getNext(HistoryState historyState) {
    historyState.addHistoryItem(current); // Delegate history management
    current = WordPair.random();
    notifyListeners(); // Only notifies about changes to 'current' and favorites
  }

  void toggleFavorite([WordPair? pair]) {
    pair = pair ?? current;
    if (favorites.contains(pair)) {
      favorites.remove(pair);
    } else {
      favorites.add(pair);
    }
    notifyListeners();
  }

  void removeFavorite(WordPair pair) {
    favorites.remove(pair);
    notifyListeners();
  }
}
