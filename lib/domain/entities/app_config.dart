// lib/domain/entities/app_config.dart
import 'package:equatable/equatable.dart';

class AppConfigEntity extends Equatable {
  final String apiUrl; // URL API backend

  const AppConfigEntity({
    required this.apiUrl,
  });

  AppConfigEntity copyWith({
    String? apiUrl,
  }) {
    return AppConfigEntity(
      apiUrl: apiUrl ?? this.apiUrl,
    );
  }

  @override
  List<Object> get props => [apiUrl];
}
