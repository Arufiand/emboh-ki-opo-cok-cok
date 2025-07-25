// lib/pages/favorites_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:belajar/src/state/app_state.dart';
import 'package:belajar/src/widget/word_pair_widget.dart'; // Reusable widgets

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty) {
      return const Center(child: Text('No favorites yet.'));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(30),
          child: Text(
            'You have '
                '${appState.favorites.length} favorites:',
            style: Theme.of(context).textTheme.headlineSmall, // Added for consistency
          ),
        ),
        Expanded(
          child: GridView(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 400,
              childAspectRatio: 400 / 80,
            ),
            children: [
              for (var pair in appState.favorites)
                WordPairListTile(
                  pair: pair,
                  showDeleteButton: true, // Indicates it's for favorites page
                ),
            ],
          ),
        ),
      ],
    );
  }
}