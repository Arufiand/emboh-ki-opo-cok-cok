// lib/domain/usecases/save_api_url.dart
import 'package:dartz/dartz.dart'; // Untuk Either
import 'package:equatable/equatable.dart'; // Untuk Equatable (parameter)
import '../../core/errors/failures.dart'; // Untuk Failure
import '../../core/usecases/usecase.dart'; // Untuk UseCase base class
import '../repositories/app_config_repository.dart'; // Import interface Repository

// SaveApiUrl adalah UseCase yang bertanggung jawab untuk menyimpan URL API.
// UseCase ini akan memanggil AppConfigRepository untuk melakukan operasi penyimpanan.
class SaveApiUrl implements UseCase<void, SaveApiUrlParams> {
  final AppConfigRepository repository;

  // Constructor untuk menginjeksi AppConfigRepository
  const SaveApiUrl(this.repository);

  // Metode 'call' adalah inti dari UseCase, menjalankan logika bisnis.
  // Metode ini menerima SaveApiUrlParams dan mengembalikan Future<Either<Failure, void>>.
  // 'void' menunjukkan bahwa operasi ini tidak mengembalikan nilai spesifik saat berhasil,
  // hanya status keberhasilan/kegagalan.
  @override
  Future<Either<Failure, void>> call(SaveApiUrlParams params) async {
    // Panggil metode saveApiUrl dari repository yang diinjeksi
    return await repository.saveApiUrl(params.apiUrl);
  }
}

// SaveApiUrlParams adalah class yang digunakan untuk membungkus parameter
// yang dibutuhkan oleh UseCase SaveApiUrl.
class SaveApiUrlParams extends Equatable {
  final String apiUrl;

  const SaveApiUrlParams({required this.apiUrl});

  @override
  List<Object> get props => [apiUrl];
}
