// lib/data/datasources/local/app_config_local_datasource.dart
import 'package:hive_flutter/hive_flutter.dart';
import '../../../core/errors/failures.dart';
import '../../../domain/entities/app_config.dart';

// Abstract class untuk AppConfigLocalDataSource
// Ini adalah kontrak untuk operasi data lokal terkait konfigurasi aplikasi.
abstract class AppConfigLocalDataSource {
  Future<void> saveApiUrl(String apiUrl);
  Future<AppConfigEntity> getApiUrl();
}

// Implementasi AppConfigLocalDataSource yang menggunakan Hive.
class AppConfigLocalDataSourceImpl implements AppConfigLocalDataSource {
  // Box Hive yang akan digunakan untuk menyimpan/mengambil konfigurasi.
  // Ini akan diinjeksi melalui GetIt.
  final Box<String> settingsBox;

  // Constructor untuk menginjeksi Hive Box
  AppConfigLocalDataSourceImpl({required this.settingsBox});

  // Key untuk menyimpan URL API di dalam Hive Box
  static const String _apiUrlKey = 'apiUrl';

  @override
  Future<void> saveApiUrl(String apiUrl) async {
    try {
      await settingsBox.put(_apiUrlKey, apiUrl);
    } catch (e) {
      // Tangani error jika penyimpanan ke Hive gagal
      throw CacheFailure('Gagal menyimpan URL API: $e');
    }
  }

  @override
  Future<AppConfigEntity> getApiUrl() async {
    try {
      final String? apiUrl = settingsBox.get(_apiUrlKey);
      if (apiUrl != null && apiUrl.isNotEmpty) {
        return AppConfigEntity(apiUrl: apiUrl);
      } else {
        // Jika tidak ada URL yang tersimpan, atau kosong
        throw CacheFailure('URL API tidak ditemukan di penyimpanan lokal.');
      }
    } catch (e) {
      // Tangani error jika pengambilan dari Hive gagal atau data tidak ditemukan
      throw CacheFailure('Gagal mengambil URL API: $e');
    }
  }
}
