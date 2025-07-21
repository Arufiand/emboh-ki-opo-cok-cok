// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For SystemChrome
import 'package:epms_flutter/app.dart'; // Your main application widget
import 'package:epms_flutter/src/injector.dart' as di; // Dependency Injection setup

/// The main entry point of the Flutter application.
/// This file handles initial setup before the app runs.
void main() async {
  // Ensure that Flutter widgets are initialized before running the app.
  // This is crucial for plugins that need to access native code (e.g., camera, NFC, path_provider).
  WidgetsFlutterBinding.ensureInitialized();

  // Optionally, set preferred orientations if your app has a fixed orientation.
  // For a general app, you might want to allow all orientations.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize all application-wide dependencies using GetIt.
  // This must happen before runApp to ensure all services and repositories
  // are available for the rest of the application.
  await di.init();

  // Run the main application widget.
  runApp(const MyApp());
}