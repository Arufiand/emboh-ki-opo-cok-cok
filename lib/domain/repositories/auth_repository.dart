// lib/domain/repositories/auth_repository.dart
import 'package:dartz/dartz.dart'; // Untuk Either
import '../../core/errors/failures.dart'; // Untuk Failure

// AuthRepository adalah interface (kontrak) untuk operasi autentikasi.
// Ini mendefinisikan apa yang harus dilakukan oleh implementasi repository autentikasi,
// tanpa peduli bagaimana implementasi itu dilakukan (misalnya, via API atau penyimpanan lokal).
abstract class AuthRepository {
  // Metode untuk melakukan login pengguna.
  // Mengembalikan Future<Either<Failure, void>>:
  // - Left (Failure) jika ada kesalahan (misal: username/password salah, error jaringan).
  // - Right (void) jika login berhasil.
  Future<Either<Failure, void>> login(String username, String password);

  Future<Either<Failure, void>> logout(); // Akan ditambahkan nanti untuk logout
  Future<Either<Failure, bool>>
      checkAuthStatus(); // Akan ditambahkan nanti untuk cek status autentikasi
}
