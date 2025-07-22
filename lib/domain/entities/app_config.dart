// lib/domain/entities/app_config.dart
import 'package:equatable/equatable.dart'; // Impor Equatable

// AppConfigEntity merepresentasikan data konfigurasi aplikasi
// di domain layer. Ini adalah representasi murni dari data bisnis,
// independen dari detail penyimpanan atau API.
class AppConfigEntity extends Equatable {
  final String apiUrl; // URL API backend

  const AppConfigEntity({
    required this.apiUrl,
  });

  // copyWith berguna untuk membuat instance baru dengan beberapa properti yang diubah
  AppConfigEntity copyWith({
    String? apiUrl,
  }) {
    return AppConfigEntity(
      apiUrl: apiUrl ?? this.apiUrl,
    );
  }

  // Equatable memungkinkan perbandingan objek berdasarkan nilai propertinya.
  // Ini berguna untuk Bloc/Cubit dalam menentukan apakah state berubah.
  @override
  List<Object> get props => [apiUrl];
}
