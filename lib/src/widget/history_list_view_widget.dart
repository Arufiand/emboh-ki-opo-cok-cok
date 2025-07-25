// lib/widgets/history_list_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:belajar/src/widget/word_pair_widget.dart';
import 'package:belajar/src/state/app_state.dart';
import 'package:belajar/src/state/history_state.dart'; // Reusable widgets

class HistoryListView extends StatefulWidget {
  const HistoryListView({super.key});

  @override
  State<HistoryListView> createState() => _HistoryListViewState();
}

class _HistoryListViewState extends State<HistoryListView> {
  final _key = GlobalKey(); // This key now correctly belongs here

  static const Gradient _maskingGradient = LinearGradient(
    colors: [Colors.transparent, Colors.black],
    stops: [0.0, 0.5],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  @override
  Widget build(BuildContext context) {
    // Watch HistoryState for history data and give it our key
    final historyState = context.watch<HistoryState>();
    historyState.historyListKey =
        _key; // HistoryState now knows its own key from here

    // We still watch MyAppState to determine if a history item is a favorite
    final appState = context.watch<MyAppState>();

    return ShaderMask(
      shaderCallback: (bounds) => _maskingGradient.createShader(bounds),
      blendMode: BlendMode.dstIn,
      child: AnimatedList(
        key: _key,
        reverse: true,
        padding: const EdgeInsets.only(top: 100),
        initialItemCount: historyState.history.length,
        itemBuilder: (context, index, animation) {
          final pair = historyState.history[index];
          return SizeTransition(
            sizeFactor: animation,
            child: Center(
              child: TextButton.icon(
                onPressed: () {
                  appState.toggleFavorite(pair);
                },
                icon: appState.favorites.contains(pair)
                    ? Icon(Icons.favorite, size: 12)
                    : SizedBox(),
                label: Text(
                  pair.asLowerCase,
                  semanticsLabel: pair.asPascalCase,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
