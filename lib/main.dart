import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Still needed for MultiProvider setup

import 'package:belajar/src/app.dart';
import 'package:belajar/src/state/app_state.dart';
import 'package:belajar/src/state/history_state.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MyAppState()),
        ChangeNotifierProvider(create: (context) => HistoryState()),
      ],
      child: const MyApp(), // MyApp is now in a separate file
    ),
  );
}