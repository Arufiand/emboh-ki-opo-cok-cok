import 'package:epms_flutter/src/core/constant/app_strings.dart';
import 'package:flutter/material.dart';
import 'features/features_name_1/presentation/pages/feature_name_1_page.dart';

class AppRouter {
  static const String initialRoute = '/';

  static const String feature1Route = '/feature1';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialRoute:
        return MaterialPageRoute(
          builder: (_) => const FeatureName1Page(),
        ); // Ganti ke route asli nantinya
      default:
        return MaterialPageRoute(
          builder: (_) => const Text(AppStrings.unknownRouteError),
        );
    }
  }
}
