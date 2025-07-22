// lib/domain/repositories/app_config_repository.dart
import 'package:dartz/dartz.dart'; // Untuk Either
import '../../core/errors/failures.dart'; // Untuk Failure
import '../entities/app_config.dart'; // Untuk AppConfigEntity

// AppConfigRepository adalah interface (kontrak) untuk repository konfigurasi aplikasi.
// Ini mendefinisikan operasi-operasi yang bisa dilakukan terkait konfigurasi API,
// tanpa peduli bagaimana operasi tersebut diimplementasikan (misalnya, dari Hive, SharedPreferences, dll.).
abstract class AppConfigRepository {
  // Metode untuk menyimpan URL API backend
  // Mengembalikan Future<Either<Failure, void>>:
  // - Left (Failure) jika ada kesalahan saat menyimpan.
  // - Right (void) jika penyimpanan berhasil.
  Future<Either<Failure, void>> saveApiUrl(String apiUrl);

  // Metode untuk mendapatkan URL API backend yang tersimpan
  // Mengembalikan Future<Either<Failure, AppConfigEntity>>:
  // - Left (Failure) jika ada kesalahan saat mengambil atau tidak ada data.
  // - Right (AppConfigEntity) jika pengambilan berhasil.
  Future<Either<Failure, AppConfigEntity>> getApiUrl();
}
