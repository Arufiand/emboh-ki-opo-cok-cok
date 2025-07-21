import 'package:epms_flutter/src/app_router.dart';
import 'package:epms_flutter/src/common/styles/app_colors.dart';
import 'package:epms_flutter/src/common/styles/app_text_styles.dart';
import 'package:epms_flutter/src/core/constant/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppInitial());
}

abstract class AppEvent {}

class AppInitialEvent extends AppEvent {}

abstract class AppState {}

class AppInitial extends AppState {}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [
        // Example of a global BlocProvider for app-wide state management.
        // Set 'lazy: false' if you want the BLoC to be created immediately when the app starts.
        BlocProvider(
          create: (context) => AppBloc(), // Provide your global AppBloc here
          lazy: false,
        ),
        // Add other global Providers or BlocProviders here as your application grows.
        // For example:
        // Provider<AuthRepository>(create: (_) => sl<AuthRepository>()),
        // ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: MaterialApp(
        title: AppStrings.appName, // Application title, displayed in task switcher
        debugShowCheckedModeBanner: false, // Set to false to hide the debug banner in release builds
        theme: ThemeData(
          primarySwatch: AppColors.primaryMaterialColor, // Define your primary color swatch
          visualDensity: VisualDensity.adaptivePlatformDensity, // Adjusts density based on platform
          fontFamily: 'Inter', // Set your default font family (ensure it's in pubspec.yaml assets)
          textTheme: AppTextStyles.textTheme, // Apply custom, app-wide text styles
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.primaryColor, // AppBar background color
            foregroundColor: AppColors.white, // AppBar text/icon color
            elevation: 0, // No shadow under the AppBar
            centerTitle: true, // Center the title on all platforms
          ),
          buttonTheme: ButtonThemeData(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), // Rounded buttons
            buttonColor: AppColors.accentColor, // Default button color
            textTheme: ButtonTextTheme.primary, // Text color for buttons
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8), // Rounded input field borders
            ),
            filled: true, // Fill the background of the input field
            fillColor: AppColors.lightGrey, // Background color of input fields
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Padding inside input fields
          ),

          // Add more theme customizations as needed to ensure a consistent UI.
          // Example: colorScheme, dialogTheme, bottomNavigationBarTheme, etc.
        ),
        // Use the centralized AppRouter for managing all application routes.
        // This makes navigation cleaner and easier to manage.
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: AppRouter.initialRoute, // Set the starting route of your application
      ),
    );
  }
}