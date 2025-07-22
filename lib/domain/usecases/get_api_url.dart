// lib/domain/usecases/get_api_url.dart
import 'package:dartz/dartz.dart'; // Untuk Either
import '../../core/errors/failures.dart'; // Untuk Failure
import '../../core/usecases/usecase.dart'; // Untuk UseCase base class dan NoParams
import '../entities/app_config.dart'; // Untuk AppConfigEntity
import '../repositories/app_config_repository.dart'; // Import interface Repository

// GetApiUrl adalah UseCase yang bertanggung jawab untuk mengambil URL API yang tersimpan.
// UseCase ini akan memanggil AppConfigRepository untuk melakukan operasi pengambilan.
class GetApiUrl implements UseCase<AppConfigEntity, NoParams> {
  final AppConfigRepository repository;

  // Constructor untuk menginjeksi AppConfigRepository
  const GetApiUrl(this.repository);

  // Metode 'call' adalah inti dari UseCase, menjalankan logika bisnis.
  // Karena tidak ada parameter input spesifik yang dibutuhkan, kita gunakan NoParams.
  // Metode ini mengembalikan Future<Either<Failure, AppConfigEntity>>.
  @override
  Future<Either<Failure, AppConfigEntity>> call(NoParams params) async {
    // Panggil metode getApiUrl dari repository yang diinjeksi
    return await repository.getApiUrl();
  }
}
