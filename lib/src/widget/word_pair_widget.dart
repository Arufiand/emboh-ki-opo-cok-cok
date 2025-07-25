// lib/widgets/word_pair_widgets.dart
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart'; // Import WordPair
import 'package:provider/provider.dart';
import 'package:belajar/src/state/app_state.dart'; // Import MyAppState

/// A reusable button that toggles the favorite status of a WordPair.
class FavoriteButton extends StatelessWidget {
  const FavoriteButton({super.key, required this.pair});
  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<MyAppState>();
    final icon = appState.favorites.contains(pair) ? Icons.favorite : Icons.favorite_border;

    return ElevatedButton.icon(
      onPressed: () => appState.toggleFavorite(pair),
      icon: Icon(icon),
      label: const Text('Like'),
    );
  }
}

/// A reusable ListTile for displaying a WordPair in a list.
/// Can show a delete button for favorites or a small favorite icon for history.
class WordPairListTile extends StatelessWidget {
  const WordPairListTile({
    super.key,
    required this.pair,
    this.showDeleteButton = false,
    this.isHistoryItem = false, // Added to differentiate behavior
  });

  final WordPair pair;
  final bool showDeleteButton;
  final bool isHistoryItem;

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<MyAppState>();
    final theme = Theme.of(context);

    Widget? leadingWidget;
    if (showDeleteButton) {
      leadingWidget = IconButton(
        icon: const Icon(Icons.delete_outline, semanticLabel: 'Delete'),
        color: theme.colorScheme.primary,
        onPressed: () {
          appState.removeFavorite(pair);
        },
      );
    } else if (isHistoryItem) {
      // For history items, show a small favorite icon if it's in favorites
      leadingWidget = appState.favorites.contains(pair)
          ? const Icon(Icons.favorite, size: 12)
          : const SizedBox(); // Empty space if not a favorite
    }

    return ListTile(
      leading: leadingWidget,
      title: Text(
        pair.asLowerCase,
        semanticsLabel: pair.asPascalCase,
        style: isHistoryItem ? theme.textTheme.labelLarge : null, // Smaller text for history
      ),
      onTap: isHistoryItem // Only make history items tappable to toggle favorite
          ? () {
        appState.toggleFavorite(pair);
      }
          : null, // No tap action for favorite list tiles (delete button handles it)
    );
  }
}