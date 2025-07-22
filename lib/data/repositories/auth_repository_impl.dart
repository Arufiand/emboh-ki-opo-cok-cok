// lib/data/repositories/auth_repository_impl.dart
import 'package:dartz/dartz.dart'; // Untuk Either
import '../../core/errors/failures.dart'; // Untuk Failure (AuthFailure)
import '../../domain/repositories/auth_repository.dart'; // Import interface AuthRepository
import '../../data/datasources/local/auth_local_datasource.dart'; // Import AuthLocalDataSource
import '../../data/datasources/remote/auth_remote_datasource.dart'; // Import AuthRemoteDataSource (untuk masa depan)
import '../../core/network/network_info.dart'; // Import NetworkInfo (untuk cek koneksi, opsional untuk hardcode)

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo; // Opsional: untuk cek koneksi

  AuthRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo, // Injeksi NetworkInfo
  });

  @override
  Future<Either<Failure, void>> login(String username, String password) async {
    // --- Logika Login Hardcode untuk Fase Awal ---
    // Di fase ini, kita mengabaikan remoteDataSource untuk login.
    // Login dianggap berhasil jika username/password sesuai hardcode.

    await Future.delayed(
        const Duration(seconds: 1)); // Simulasi penundaan proses

    if (username == "admin" && password == "admin") {
      try {
        // Jika login hardcode berhasil, simpan status login ke lokal
        await localDataSource.saveLoginStatus(true);
        return const Right(unit); // Berhasil
      } on CacheFailure catch (e) {
        // Tangani error jika gagal menyimpan ke lokal
        return Left(e);
      }
    } else {
      // Jika kredensial hardcode salah
      return const Left(AuthFailure('Username atau password salah.'));
    }

    // --- Contoh Logika untuk Integrasi API di Masa Depan (dikomentari) ---
    /*
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.login(username, password); // Coba login via API
        await localDataSource.saveLoginStatus(true); // Jika API berhasil, simpan status lokal
        return const Right(unit);
      } on ServerFailure catch (e) {
        return Left(e); // Tangani error dari API
      } on NetworkFailure catch (e) {
        return Left(e); // Tangani error jaringan saat komunikasi API
      }
    } else {
      // Jika tidak ada koneksi, bisa coba login offline (jika ada mekanisme token lokal)
      // Untuk saat ini, kita akan melempar NetworkFailure
      return const Left(NetworkFailure('Tidak ada koneksi internet.'));
    }
    */
  }

  // Metode tambahan yang mungkin akan diimplementasikan di AuthRepositoryImpl
  // @override
  // Future<Either<Failure, void>> logout() async {
  //   try {
  //     await localDataSource.clearLoginStatus();
  //     // Jika ada logout API: await remoteDataSource.logout();
  //     return const Right(unit);
  //   } on CacheFailure catch (e) {
  //     return Left(e);
  //   } on ServerFailure catch (e) { // Jika ada remote logout
  //     return Left(e);
  //   }
  // }

  // @override
  // Future<Either<Failure, bool>> checkAuthStatus() async {
  //   try {
  //     final bool isLoggedIn = await localDataSource.getLoginStatus();
  //     return Right(isLoggedIn);
  //   } on CacheFailure catch (e) {
  //     return Left(e);
  //   }
  // }
}
