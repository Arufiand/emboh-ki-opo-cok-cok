// lib/pages/generator_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:english_words/english_words.dart'; // Import WordPair

import 'package:belajar/src/state/app_state.dart';
import 'package:belajar/src/state/history_state.dart';
import 'package:belajar/src/widget/big_card_widget.dart';
import 'package:belajar/src/widget/history_list_view_widget.dart';
import 'package:belajar/src/widget/word_pair_widget.dart'; // Reusable widgets

class GeneratorScreen extends StatelessWidget {
  const GeneratorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var historyState = context.watch<HistoryState>(); // Watch HistoryState
    var pair = appState.current;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(flex: 3, child: const HistoryListView()),
          const SizedBox(height: 10),
          BigCard(pair: pair),
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FavoriteButton(pair: pair), // Replaced with reusable FavoriteButton
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.getNext(historyState); // Pass HistoryState instance
                },
                child: const Text('Next'),
              ),
            ],
          ),
          Spacer(flex: 2),
        ],
      ),
    );
  }
}