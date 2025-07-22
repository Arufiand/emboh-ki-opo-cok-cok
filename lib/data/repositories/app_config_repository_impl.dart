// lib/data/repositories/app_config_repository_impl.dart
import 'package:dartz/dartz.dart'; // Impor Dartz untuk Either
import '../../core/errors/failures.dart'; // Impor Failure
import '../../domain/entities/app_config.dart'; // Impor AppConfigEntity
import '../../domain/repositories/app_config_repository.dart'; // Impor AppConfigRepository interface
import '../datasources/local/app_config_local_datasource.dart'; // Impor AppConfigLocalDataSource

// AppConfigRepositoryImpl adalah implementasi konkret dari AppConfigRepository.
// Kelas ini bertanggung jawab untuk mengambil data dari DataSource (lokal) dan
// mengubahnya menjadi tipe yang dapat dipahami oleh Domain Layer (Either<Failure, Type>).
class AppConfigRepositoryImpl implements AppConfigRepository {
  final AppConfigLocalDataSource localDataSource;

  // Constructor untuk menginjeksi DataSource lokal
  AppConfigRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, AppConfigEntity>> getApiUrl() async {
    try {
      // Panggil metode dari localDataSource untuk mendapatkan URL
      final AppConfigEntity appConfig = await localDataSource.getApiUrl();
      // Jika berhasil, bungkus dalam Right
      return Right(appConfig);
    } on CacheFailure catch (e) {
      // Jika ada CacheFailure dari DataSource, bungkus dalam Left
      return Left(CacheFailure(e.message));
    } catch (e) {
      // Tangani error lain yang tidak terduga sebagai ServerFailure (generik)
      // Ini bisa diubah menjadi UnknownFailure jika Anda memiliki tipe tersebut
      return Left(ServerFailure(
          'Terjadi kesalahan tidak terduga saat mengambil API URL.'));
    }
  }

  @override
  Future<Either<Failure, void>> saveApiUrl(String apiUrl) async {
    try {
      // Panggil metode dari localDataSource untuk menyimpan URL
      await localDataSource.saveApiUrl(apiUrl);
      // Jika berhasil, bungkus dalam Right(unit)
      // unit adalah sebuah singleton yang merepresentasikan nilai 'void' di dalam Either
      return const Right(unit);
    } on CacheFailure catch (e) {
      // Jika ada CacheFailure dari DataSource, bungkus dalam Left
      return Left(CacheFailure(e.message));
    } catch (e) {
      // Tangani error lain yang tidak terduga
      return Left(ServerFailure(
          'Terjadi kesalahan tidak terduga saat menyimpan API URL.'));
    }
  }
}
